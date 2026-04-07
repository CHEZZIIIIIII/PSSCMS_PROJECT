<?php
session_start();

if(!isset($_SESSION['username']) || !isset($_SESSION['logged_in'])) {
    header('Location: ../index.php');
    exit();
}

require_once '../config.php';

$grade = 2;
$section = 'Bougainvillea';
$section_db = strtolower(str_replace(' ', '', $section));
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
        if(strtolower($teacher_section) == 'bougainvillea') {
            $has_access = true;
        }
    }
    mysqli_stmt_close($stmt);
}

// Fetch students from main table with gender and middle initial
$students_query = "SELECT lrn_number, CONCAT(last_name, ', ', first_name, ' ', LEFT(middle_name, 1), '.') as full_name, gender FROM tblgrade2bougainvillea ORDER BY last_name, first_name";
$students_result = mysqli_query($conn, $students_query);

// Fetch LRNs that already have a uniform record (to disable in Add dropdown)
$existing_lrns = [];
$existing_result = mysqli_query($conn, "SELECT lrn FROM tblgrade2bougainvilleauniform");
while($erow = mysqli_fetch_assoc($existing_result)) {
    $existing_lrns[] = $erow['lrn'];
}

// Handle Add/Update Uniform Record
if(isset($_POST['action']) && $_POST['action'] == 'save' && $has_access) {
    $lrn = mysqli_real_escape_string($conn, $_POST['lrn']);
    $student_name = mysqli_real_escape_string($conn, $_POST['student_name']);
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    $pe_tshirt = mysqli_real_escape_string($conn, $_POST['pe_tshirt']);
    $pe_pants = mysqli_real_escape_string($conn, $_POST['pe_pants']);
    $socks = mysqli_real_escape_string($conn, $_POST['socks']);
    $shoes_raw = trim($_POST['shoes']);
    $school_uniform = mysqli_real_escape_string($conn, $_POST['school_uniform']);
    $uniform_bottom = mysqli_real_escape_string($conn, $_POST['uniform_bottom']);
    $created_by = $_SESSION['username'];

    // Validate shoes: must be numeric and between 1 and 50 (or empty)
    $validation_error = false;
    if($shoes_raw !== '') {
        if(!ctype_digit($shoes_raw) || intval($shoes_raw) < 1 || intval($shoes_raw) > 50) {
            $error_message = "Shoes size must be a whole number between 1 and 50.";
            $validation_error = true;
        }
    }
    $shoes = $validation_error ? '' : mysqli_real_escape_string($conn, $shoes_raw);

    if(!$validation_error) {
        // Check if record exists
        $check_query = "SELECT id FROM tblgrade2bougainvilleauniform WHERE lrn = ?";
        $stmt = mysqli_prepare($conn, $check_query);
        mysqli_stmt_bind_param($stmt, "s", $lrn);
        mysqli_stmt_execute($stmt);
        $check_result = mysqli_stmt_get_result($stmt);
        
        if(mysqli_num_rows($check_result) > 0) {
            $update_query = "UPDATE tblgrade2bougainvilleauniform SET student_name=?, gender=?, pe_tshirt=?, pe_pants=?, socks=?, shoes=?, school_uniform=?, uniform_bottom=?, created_by=? WHERE lrn=?";
            $stmt = mysqli_prepare($conn, $update_query);
            mysqli_stmt_bind_param($stmt, "ssssssssss", $student_name, $gender, $pe_tshirt, $pe_pants, $socks, $shoes, $school_uniform, $uniform_bottom, $created_by, $lrn);
            if(mysqli_stmt_execute($stmt)) {
                $success_message = "Uniform record updated successfully!";
                logAction($conn, 'EDIT', 'Grade 2 - Bougainvillea (Uniform)', $student_name, 'Updated uniform record', $created_by);
            } else {
                $error_message = "Error updating record: " . mysqli_error($conn);
            }
        } else {
            $insert_query = "INSERT INTO tblgrade2bougainvilleauniform (lrn, student_name, gender, pe_tshirt, pe_pants, socks, shoes, school_uniform, uniform_bottom, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            $stmt = mysqli_prepare($conn, $insert_query);
            mysqli_stmt_bind_param($stmt, "ssssssssss", $lrn, $student_name, $gender, $pe_tshirt, $pe_pants, $socks, $shoes, $school_uniform, $uniform_bottom, $created_by);
            if(mysqli_stmt_execute($stmt)) {
                $success_message = "Uniform record added successfully!";
                logAction($conn, 'ADD', 'Grade 2 - Bougainvillea (Uniform)', $student_name, 'Added new uniform record', $created_by);
            } else {
                $error_message = "Error adding record: " . mysqli_error($conn);
            }
        }
        mysqli_stmt_close($stmt);

        // Refresh existing LRNs after save
        $existing_lrns = [];
        $existing_result2 = mysqli_query($conn, "SELECT lrn FROM tblgrade2bougainvilleauniform");
        while($erow = mysqli_fetch_assoc($existing_result2)) {
            $existing_lrns[] = $erow['lrn'];
        }
    }
}

// Handle Delete
if(isset($_GET['delete']) && $has_access) {
    $id = intval($_GET['delete']);
    
    $get_name_query = "SELECT student_name FROM tblgrade2bougainvilleauniform WHERE id = ?";
    $stmt = mysqli_prepare($conn, $get_name_query);
    mysqli_stmt_bind_param($stmt, "i", $id);
    mysqli_stmt_execute($stmt);
    $name_result = mysqli_stmt_get_result($stmt);
    $student_name = '';
    if($row = mysqli_fetch_assoc($name_result)) {
        $student_name = $row['student_name'];
    }
    mysqli_stmt_close($stmt);
    
    $delete_query = "DELETE FROM tblgrade2bougainvilleauniform WHERE id = ?";
    $stmt = mysqli_prepare($conn, $delete_query);
    mysqli_stmt_bind_param($stmt, "i", $id);
    if(mysqli_stmt_execute($stmt)) {
        $success_message = "Record deleted successfully!";
        logAction($conn, 'DELETE', 'Grade 2 - Bougainvillea (Uniform)', $student_name, 'Deleted uniform record', $_SESSION['username']);
        // Refresh existing LRNs after delete
        $existing_lrns = [];
        $existing_result3 = mysqli_query($conn, "SELECT lrn FROM tblgrade2bougainvilleauniform");
        while($erow = mysqli_fetch_assoc($existing_result3)) {
            $existing_lrns[] = $erow['lrn'];
        }
    } else {
        $error_message = "Error deleting record.";
    }
    mysqli_stmt_close($stmt);
}

// Fetch all uniform records with search functionality
$search = '';
if(isset($_GET['search']) && !empty($_GET['search'])) {
    $search = mysqli_real_escape_string($conn, $_GET['search']);
    $query = "SELECT * FROM tblgrade2bougainvilleauniform WHERE lrn LIKE '%$search%' OR student_name LIKE '%$search%' ORDER BY student_name";
} else {
    $query = "SELECT * FROM tblgrade2bougainvilleauniform ORDER BY student_name";
}
$result = mysqli_query($conn, $query);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Uniforms - Grade <?php echo $grade; ?> <?php echo ucwords(str_replace("_", " ", $section)); ?></title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="uniform_styles.css">
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
                    <div class="school-subtitle">Uniform Management System</div>
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
            <span class="current"><?php echo ucwords(str_replace("_", " ", $section)); ?> - Uniforms</span>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons-top no-print">
            <button class="back-btn" onclick="location.href='../select_section.php?grade=<?php echo $grade; ?>'">
                <i class="fas fa-arrow-left"></i> Back to Sections
            </button>
            <button class="supplies-btn" onclick="location.href='bougainvillea_supplies.php'">
                <i class="fas fa-book"></i> Go to Supplies
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
                        <i class="fas fa-tshirt"></i>
                        Grade 2 - Bougainvillea Uniforms
                    </h1>
                    <p class="page-description">Manage uniform sizes and requirements</p>
                </div>
                <?php if($has_access): ?>
                    <button class="btn-add" onclick="openAddModal()">
                        <i class="fas fa-plus"></i>
                        Add School Uniform
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
                        <button type="button" class="btn-clear" onclick="location.href='bougainvillea_uniform.php'">
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
                            <th>Gender</th>
                            <th>PE T-Shirt</th>
                            <th>PE Pants</th>
                            <th>Socks</th>
                            <th>Shoes</th>
                            <th>School Uniform</th>
                            <th>Uniform Bottom</th>
                            <th class="no-print">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if(mysqli_num_rows($result) > 0): ?>
                            <?php while($row = mysqli_fetch_assoc($result)): ?>
                                <tr>
                                    <td><span class="lrn-badge"><?php echo htmlspecialchars($row['lrn']); ?></span></td>
                                    <td><strong><?php echo htmlspecialchars($row['student_name']); ?></strong></td>
                                    <td><span class="gender-badge <?php echo strtolower($row['gender']); ?>"><?php echo htmlspecialchars($row['gender']); ?></span></td>
                                    <td><?php echo htmlspecialchars($row['pe_tshirt']); ?></td>
                                    <td><?php echo htmlspecialchars($row['pe_pants']); ?></td>
                                    <td><?php echo htmlspecialchars($row['socks']); ?></td>
                                    <td><?php echo htmlspecialchars($row['shoes']); ?></td>
                                    <td><?php echo htmlspecialchars($row['school_uniform']); ?></td>
                                    <td><?php echo htmlspecialchars($row['uniform_bottom']); ?> <span class="bottom-type">(<?php echo $row['gender'] == 'FEMALE' ? 'Skirt' : 'Slacks'; ?>)</span></td>
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
                                <td colspan="10" class="no-data">
                                    <i class="fas fa-tshirt"></i>
                                    <p><?php echo !empty($search) ? 'No uniform records found matching your search.' : 'No uniform records found.'; ?></p>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add/Edit Modal -->
    <div id="uniformModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle"><i class="fas fa-tshirt"></i> Add Uniform Record</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="uniformForm" method="POST">
                <input type="hidden" name="action" value="save">
                
                <div class="modal-body">
                    <div class="form-grid">
                        <div class="info-box">
                            <i class="fas fa-info-circle"></i>
                            <p><strong>Note:</strong> Uniform Bottom - FEMALE students get Skirt sizes, MALE students get Slacks sizes. Shoes are in number sizes (1–50). School Uniform and PE items use XS, S, M, L, XL sizes.</p>
                        </div>
                        <div class="form-group">
                            <label for="lrn">LRN <span class="required">*</span></label>
                            <select id="lrn" name="lrn" required onchange="updateStudentInfo()">
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
                                        data-gender="<?php echo htmlspecialchars($student['gender']); ?>"
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
                        <div class="form-group full-width">
                            <label for="gender">Gender <span class="required">*</span></label>
                            <input type="text" id="gender" name="gender" required readonly>
                        </div>
                        <div class="form-group">
                            <label for="pe_tshirt">PE T-Shirt</label>
                            <select id="pe_tshirt" name="pe_tshirt">
                                <option value="">Select Size</option>
                                <option value="XS">XS - Extra Small</option>
                                <option value="S">S - Small</option>
                                <option value="M">M - Medium</option>
                                <option value="L">L - Large</option>
                                <option value="XL">XL - Extra Large</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="pe_pants">PE Pants</label>
                            <select id="pe_pants" name="pe_pants">
                                <option value="">Select Size</option>
                                <option value="XS">XS - Extra Small</option>
                                <option value="S">S - Small</option>
                                <option value="M">M - Medium</option>
                                <option value="L">L - Large</option>
                                <option value="XL">XL - Extra Large</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="socks">Socks</label>
                            <select id="socks" name="socks">
                                <option value="">Select Size</option>
                                <option value="XS">XS - Extra Small</option>
                                <option value="S">S - Small</option>
                                <option value="M">M - Medium</option>
                                <option value="L">L - Large</option>
                                <option value="XL">XL - Extra Large</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="shoes">Shoes <small>(number size, 1–50)</small></label>
                            <input type="number" id="shoes" name="shoes" 
                                   placeholder="e.g., 30, 35, 40" 
                                   min="1" max="50" 
                                   oninput="validateShoes(this)">
                        </div>
                        <div class="form-group">
                            <label for="school_uniform">School Uniform</label>
                            <select id="school_uniform" name="school_uniform">
                                <option value="">Select Size</option>
                                <option value="XS">XS - Extra Small</option>
                                <option value="S">S - Small</option>
                                <option value="M">M - Medium</option>
                                <option value="L">L - Large</option>
                                <option value="XL">XL - Extra Large</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="uniform_bottom"><span id="bottom_label">Uniform Bottom</span></label>
                            <select id="uniform_bottom" name="uniform_bottom">
                                <option value="">Select Size</option>
                                <option value="XS">XS - Extra Small</option>
                                <option value="S">S - Small</option>
                                <option value="M">M - Medium</option>
                                <option value="L">L - Large</option>
                                <option value="XL">XL - Extra Large</option>
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

</body>
    <script src="uniform_scripts.js"></script>
</html>
<?php
mysqli_close($conn);
?>