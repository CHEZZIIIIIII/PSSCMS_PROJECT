<?php
session_start();

if(!isset($_SESSION['username']) || !isset($_SESSION['logged_in'])) {
    header('Location: ../index.php');
    exit();
}

require_once '../config.php';

$grade = 4;
$section = 'lapu_lapu';
$section_db = strtolower(str_replace(' ', '', $section));
$student_table = 'tblgrade'.$grade.$section_db;
$supplies_table = $student_table.'supplies';
$log_section = 'Grade '.$grade.' - '.ucwords(str_replace('_', ' ', $section)).' (Supplies)';
$is_admin = ($_SESSION['usertype'] == 'admin');

// Function to log actions
function logAction($conn, $action_type, $section, $student_name, $details, $created_by) {
    $date_created = date('Y-m-d H:i:s');
    $log_query = "INSERT INTO tbllogs (action_type, section, student_name, details, created_by, date_created) 
                  VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($conn, $log_query);
    mysqli_stmt_bind_param($stmt, "ssssss", $action_type, $section, $student_name, $details, $created_by, $date_created);
    mysqli_stmt_execute($stmt);
    mysqli_stmt_close($stmt);
}

// Check if teacher has access to this section
$has_access = false;
if($is_admin) {
    $has_access = true;
} else if($_SESSION['usertype'] == 'teacher') {
    $username = $_SESSION['username'];
    $section_query = "SELECT section FROM tblaccounts WHERE username = ?";
    $stmt = mysqli_prepare($conn, $section_query);
    mysqli_stmt_bind_param($stmt, "s", $username);
    mysqli_stmt_execute($stmt);
    $section_result = mysqli_stmt_get_result($stmt);
    
    if($row = mysqli_fetch_assoc($section_result)) {
        $teacher_section = $row['section'];
        if(strtolower($teacher_section) == strtolower($section)) {
            $has_access = true;
        }
    }
    mysqli_stmt_close($stmt);
}

// Fetch students from main table with middle initial
$students_query = "SELECT lrn_number, CONCAT(last_name, ', ', first_name, ' ', LEFT(middle_name, 1), '.') as full_name FROM {$student_table} ORDER BY last_name, first_name";
$students_result = mysqli_query($conn, $students_query);

// Fetch LRNs that already have a supply record (to disable in Add dropdown)
$existing_lrns = [];
$existing_result = mysqli_query($conn, "SELECT lrn FROM {$student_table}supplies");
while($erow = mysqli_fetch_assoc($existing_result)) {
    $existing_lrns[] = $erow['lrn'];
}

// Supply fields list and individual limits
$supply_fields = ['notebooks', 'padpaper', 'bag', 'ballpen', 'pencil', 'sharpener', 'crayons', 'eraser', 'ruler', 'scissors', 'glue'];
$supply_limits = [
    'notebooks' => 8,
    'padpaper' => 2,
    'bag' => 1,
    'ballpen' => 2,
    'pencil' => 2,
    'sharpener' => 2,
    'crayons' => 1,
    'eraser' => 2,
    'ruler' => 1,
    'scissors' => 1,
    'glue' => 1
];

// Handle Add/Update Supply Record
if(isset($_POST['action']) && $_POST['action'] == 'save' && $has_access) {
    $lrn = mysqli_real_escape_string($conn, $_POST['lrn']);
    $student_name = mysqli_real_escape_string($conn, $_POST['student_name']);
    $created_by = $_SESSION['username'];

    // Collect and validate supply quantities
    $validation_error = false;
    $supplies = [];

    foreach($supply_fields as $field) {
        $val = isset($_POST[$field]) ? trim($_POST[$field]) : '';
        $max = $supply_limits[$field];
        
        if($val !== '') {
            // Force integer and strictly check range with individual limits
            if(!is_numeric($val) || (int)$val < 0 || (int)$val > $max) {
                $error_message = "Supply quantities must be valid. Check your entries and verify the limits for each item.";
                $validation_error = true;
                break;
            }
            $supplies[$field] = (int)$val;
        } else {
            $supplies[$field] = 0; // Default to 0 if empty
        }
    }

    if(!$validation_error) {
        $notebooks  = $supplies['notebooks'];
        $padpaper   = $supplies['padpaper'];
        $bag        = $supplies['bag'];
        $ballpen    = $supplies['ballpen'];
        $pencil     = $supplies['pencil'];
        $sharpener  = $supplies['sharpener'];
        $crayons    = $supplies['crayons'];
        $eraser     = $supplies['eraser'];
        $ruler      = $supplies['ruler'];
        $scissors   = $supplies['scissors'];
        $glue       = $supplies['glue'];

        // Check if record exists
        $check_query = "SELECT id FROM {$student_table}supplies WHERE lrn = ?";
        $stmt = mysqli_prepare($conn, $check_query);
        mysqli_stmt_bind_param($stmt, "s", $lrn);
        mysqli_stmt_execute($stmt);
        $check_result = mysqli_stmt_get_result($stmt);
        
        if(mysqli_num_rows($check_result) > 0) {
            $update_query = "UPDATE {$supplies_table} SET student_name=?, notebooks=?, padpaper=?, bag=?, ballpen=?, pencil=?, sharpener=?, crayons=?, eraser=?, ruler=?, scissors=?, glue=?, created_by=? WHERE lrn=?";
            $stmt = mysqli_prepare($conn, $update_query);
            mysqli_stmt_bind_param($stmt, "siiiiiiiiiiiss", $student_name, $notebooks, $padpaper, $bag, $ballpen, $pencil, $sharpener, $crayons, $eraser, $ruler, $scissors, $glue, $created_by, $lrn);
            if(mysqli_stmt_execute($stmt)) {
                $success_message = "School supplies record updated successfully!";
                logAction($conn, 'EDIT', $log_section, $student_name, 'Updated supply record', $created_by);
            } else {
                $error_message = "Error updating record: " . mysqli_error($conn);
            }
        } else {
            $insert_query = "INSERT INTO {$supplies_table} (lrn, student_name, notebooks, padpaper, bag, ballpen, pencil, sharpener, crayons, eraser, ruler, scissors, glue, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = mysqli_prepare($conn, $insert_query);
            mysqli_stmt_bind_param($stmt, "ssiiiiiiiiiiis", $lrn, $student_name, $notebooks, $padpaper, $bag, $ballpen, $pencil, $sharpener, $crayons, $eraser, $ruler, $scissors, $glue, $created_by);
            if(mysqli_stmt_execute($stmt)) {
                $success_message = "School supplies record added successfully!";
                logAction($conn, 'ADD', $log_section, $student_name, 'Added new supply record', $created_by);
            } else {
                $error_message = "Error adding record: " . mysqli_error($conn);
            }
        }
        mysqli_stmt_close($stmt);

        // Refresh existing LRNs after save
        $existing_lrns = [];
        $existing_result2 = mysqli_query($conn, "SELECT lrn FROM {$student_table}supplies");
        while($erow = mysqli_fetch_assoc($existing_result2)) {
            $existing_lrns[] = $erow['lrn'];
        }
    }
}

if(isset($_GET['delete']) && $has_access) {
    $id = intval($_GET['delete']);
    
    $get_name_query = "SELECT student_name FROM {$student_table}supplies WHERE id = ?";
    $stmt = mysqli_prepare($conn, $get_name_query);
    mysqli_stmt_bind_param($stmt, "i", $id);
    mysqli_stmt_execute($stmt);
    $name_result = mysqli_stmt_get_result($stmt);
    $student_name = '';
    if($row = mysqli_fetch_assoc($name_result)) {
        $student_name = $row['student_name'];
    }
    mysqli_stmt_close($stmt);
    
    $delete_query = "DELETE FROM {$student_table}supplies WHERE id = ?";
    $stmt = mysqli_prepare($conn, $delete_query);
    mysqli_stmt_bind_param($stmt, "i", $id);
    if(mysqli_stmt_execute($stmt)) {
        $success_message = "Record deleted successfully!";
        logAction($conn, 'DELETE', $log_section, $student_name, 'Deleted supply record', $_SESSION['username']);
        // Refresh existing LRNs after delete
        $existing_lrns = [];
        $existing_result3 = mysqli_query($conn, "SELECT lrn FROM {$student_table}supplies");
        while($erow = mysqli_fetch_assoc($existing_result3)) {
            $existing_lrns[] = $erow['lrn'];
        }
    } else {
        $error_message = "Error deleting record.";
    }
    mysqli_stmt_close($stmt);
}

// Fetch all supply records with search functionality
$search = '';
if(isset($_GET['search']) && !empty($_GET['search'])) {
    $search = mysqli_real_escape_string($conn, $_GET['search']);
    $query = "SELECT * FROM {$student_table}supplies WHERE lrn LIKE '%$search%' OR student_name LIKE '%$search%' ORDER BY student_name";
} else {
    $query = "SELECT * FROM {$student_table}supplies ORDER BY student_name";
}
$result = mysqli_query($conn, $query);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>School Supplies - Grade <?php echo $grade; ?> <?php echo ucwords(str_replace("_", " ", $section)); ?></title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="supplies_styles.css">
</head>
<body>
    <!-- Header -->
    <div class="header no-print">
        <div class="header-content">
            <div class="header-left">
                <div class="school-logo-header">
                    <img src="../logo.png" alt="Palatiw Elementary School Logo" onerror="this.style.display='none'">
                </div>
                <div class="school-info">
                    <div class="school-name">Palatiw Elementary School</div>
                    <div class="school-subtitle">School Supplies Management System</div>
                </div>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <div class="user-greeting">Welcome back,</div>
                    <div class="user-name-badge">
                        <span class="user-name"><?php echo htmlspecialchars($_SESSION['username']); ?></span>
                        <span class="user-badge"><?php echo strtoupper($_SESSION['usertype']); ?></span>
                    </div>
                </div>
                <button class="btn-logout" onclick="location.href='../logout.php'">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </button>
            </div>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb no-print">
            <a href="../select_grade.php"><i class="fas fa-home"></i> Grade Selection</a>
            <span>›</span>
            <a href="../select_section.php?grade=<?php echo $grade; ?>">Grade <?php echo $grade; ?> Sections</a>
            <span>›</span>
            <span class="current"><?php echo ucwords(str_replace("_", " ", $section)); ?> - School Supplies</span>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons-top no-print">
            <button class="back-btn" onclick="location.href='../select_section.php?grade=<?php echo $grade; ?>'">
                <i class="fas fa-arrow-left"></i> Back to Sections
            </button>
            <button class="uniform-btn" onclick="location.href='<?php echo $section_db; ?>_uniform.php'">
                <i class="fas fa-tshirt"></i> Go to Uniforms
            </button>
            <button class="print-btn" onclick="window.print()">
                <i class="fas fa-print"></i> Print List
            </button>
        </div>

        <!-- Alerts -->
        <?php if(isset($success_message)): ?>
            <div class="alert alert-success no-print">
                <i class="fas fa-check-circle"></i>
                <?php echo $success_message; ?>
            </div>
        <?php endif; ?>

        <?php if(isset($error_message)): ?>
            <div class="alert alert-error no-print">
                <i class="fas fa-exclamation-circle"></i>
                <?php echo $error_message; ?>
            </div>
        <?php endif; ?>

        <!-- Page Header -->
        <div class="page-header no-print">
            <div class="page-header-content">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-book"></i>
                        Grade <?php echo $grade; ?> - <?php echo ucwords(str_replace("_", " ", $section)); ?> School Supplies
                    </h1>
                    <p class="page-description">Manage school supplies inventory and requirements</p>
                </div>
                <?php if($has_access): ?>
                    <button class="btn-add" onclick="openAddModal()">
                        <i class="fas fa-plus"></i>
                        Add School Supply
                    </button>
                <?php endif; ?>
            </div>
        </div>

        <!-- Search Section -->
        <div class="search-section no-print">
            <form method="GET" action="">
                <div class="search-container">
                    <div class="search-input-wrapper">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" 
                               name="search" 
                               class="search-input" 
                               placeholder="Search by LRN or Student Name..." 
                               value="<?php echo htmlspecialchars($search); ?>">
                    </div>
                    <button type="submit" class="btn-search">
                        <i class="fas fa-search"></i> Search
                    </button>
                    <?php if(!empty($search)): ?>
                        <button type="button" class="btn-clear" onclick="location.href='<?php echo $section_db; ?>_supplies.php'">
                            <i class="fas fa-times"></i> Clear
                        </button>
                    <?php endif; ?>
                </div>
            </form>
            <?php if(!empty($search)): ?>
                <div class="search-info">
                    <i class="fas fa-info-circle"></i> 
                    Showing results for: <strong>"<?php echo htmlspecialchars($search); ?>"</strong>
                </div>
            <?php endif; ?>
        </div>

        <!-- Table Section -->
        <div class="table-section">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>LRN</th>
                            <th>Student Name</th>
                            <th>Notebooks</th>
                            <th>Pad Paper</th>
                            <th>Bag</th>
                            <th>Ballpen</th>
                            <th>Pencil</th>
                            <th>Sharpener</th>
                            <th>Crayons</th>
                            <th>Eraser</th>
                            <th>Ruler</th>
                            <th>Scissors</th>
                            <th>Glue</th>
                            <th class="no-print">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if(mysqli_num_rows($result) > 0): ?>
                            <?php while($row = mysqli_fetch_assoc($result)): ?>
                                <tr>
                                    <td><span class="lrn-badge"><?php echo htmlspecialchars($row['lrn']); ?></span></td>
                                    <td><strong><?php echo htmlspecialchars($row['student_name']); ?></strong></td>
                                    <td><?php echo htmlspecialchars($row['notebooks']); ?></td>
                                    <td><?php echo htmlspecialchars($row['padpaper']); ?></td>
                                    <td><?php echo htmlspecialchars($row['bag']); ?></td>
                                    <td><?php echo htmlspecialchars($row['ballpen']); ?></td>
                                    <td><?php echo htmlspecialchars($row['pencil']); ?></td>
                                    <td><?php echo htmlspecialchars($row['sharpener']); ?></td>
                                    <td><?php echo htmlspecialchars($row['crayons']); ?></td>
                                    <td><?php echo htmlspecialchars($row['eraser']); ?></td>
                                    <td><?php echo htmlspecialchars($row['ruler']); ?></td>
                                    <td><?php echo htmlspecialchars($row['scissors']); ?></td>
                                    <td><?php echo htmlspecialchars($row['glue']); ?></td>
                                    <td class="no-print">
                                        <div class="action-buttons">
                                            <?php if($has_access): ?>
                                                <button class="btn-edit" onclick='editRecord(<?php echo json_encode($row); ?>)' title="Edit Record">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn-delete" onclick="deleteRecord(<?php echo $row['id']; ?>, '<?php echo htmlspecialchars($row['student_name']); ?>')" title="Delete Record">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            <?php endif; ?>
                                        </div>
                                    </td>
                                </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="14" class="no-data">
                                    <i class="fas fa-book-open"></i>
                                    <p><?php echo !empty($search) ? 'No supply records found matching your search.' : 'No supply records found.'; ?></p>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add/Edit Modal -->
    <div id="supplyModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle"><i class="fas fa-book"></i> Add Supply Record</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="supplyForm" method="POST" onsubmit="return validateSupplyForm()">
                <input type="hidden" name="action" value="save">
                <input type="hidden" id="hidden_lrn" name="lrn" value="">

                <div class="modal-body">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="lrn">LRN <span class="required">*</span></label>
                            <select id="lrn" onchange="updateStudentName()">
                                <option value="">Select Student</option>
                                <?php 
                                mysqli_data_seek($students_result, 0);
                                while($student = mysqli_fetch_assoc($students_result)):
                                    $lrn_val = $student['lrn_number'];
                                    $is_taken = in_array($lrn_val, $existing_lrns);
                                ?>
                                    <option 
                                        value="<?php echo htmlspecialchars($lrn_val); ?>"
                                        data-name="<?php echo htmlspecialchars($student['full_name']); ?>"
                                        <?php if($is_taken) echo 'disabled class="option-disabled"'; ?>>
                                        <?php echo htmlspecialchars($lrn_val) . ' - ' . htmlspecialchars($student['full_name']); ?>
                                        <?php if($is_taken) echo ' (already has record)'; ?>
                                    </option>
                                <?php endwhile; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="student_name">Student Name <span class="required">*</span></label>
                            <input type="text" id="student_name" name="student_name" required readonly>
                        </div>
                        <div class="form-group">
                            <label for="notebooks">Notebooks <span class="required">*</span></label>
                            <select id="notebooks" name="notebooks" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['notebooks']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="padpaper">Pad Paper <span class="required">*</span></label>
                            <select id="padpaper" name="padpaper" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['padpaper']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="bag">Bag <span class="required">*</span></label>
                            <select id="bag" name="bag" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['bag']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="ballpen">Ballpen <span class="required">*</span></label>
                            <select id="ballpen" name="ballpen" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['ballpen']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="pencil">Pencil <span class="required">*</span></label>
                            <select id="pencil" name="pencil" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['pencil']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="sharpener">Sharpener <span class="required">*</span></label>
                            <select id="sharpener" name="sharpener" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['sharpener']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="crayons">Crayons <span class="required">*</span></label>
                            <select id="crayons" name="crayons" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['crayons']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="eraser">Eraser <span class="required">*</span></label>
                            <select id="eraser" name="eraser" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['eraser']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="ruler">Ruler <span class="required">*</span></label>
                            <select id="ruler" name="ruler" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['ruler']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="scissors">Scissors <span class="required">*</span></label>
                            <select id="scissors" name="scissors" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['scissors']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                        <div class="form-group full-width">
                            <label for="glue">Glue <span class="required">*</span></label>
                            <select id="glue" name="glue" required>
                                <option value="">Select Quantity</option>
                                <?php for($i = 0; $i <= $supply_limits['glue']; $i++): ?>
                                    <option value="<?php echo $i; ?>"><?php echo $i; ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> Save Record
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="supplies_scripts.js"></script>
    <script>
        // Client-side validation before form submit
        function validateSupplyForm() {
            // On edit mode, hidden_lrn is used; on add mode, the visible select is used
            const hiddenLrn = document.getElementById('hidden_lrn').value;
            const lrnSelect = document.getElementById('lrn');

            // If hidden_lrn is empty (add mode), validate the visible select
            if (!hiddenLrn && !lrnSelect.value) {
                alert('Please select a student.');
                lrnSelect.focus();
                return false;
            }

            const fields = ['notebooks','padpaper','bag','ballpen','pencil','sharpener','crayons','eraser','ruler','scissors','glue'];
            for (let field of fields) {
                const input = document.getElementById(field);
                if (input.value === '') {
                    alert('Please select a quantity for ' + field.charAt(0).toUpperCase() + field.slice(1));
                    input.focus();
                    return false;
                }
            }

            // If adding (not editing), sync hidden_lrn from visible select
            if (!hiddenLrn) {
                document.getElementById('hidden_lrn').value = lrnSelect.value;
            }

            return true;
        }
    </script>
</body>
</html>
<?php
mysqli_close($conn);
?>