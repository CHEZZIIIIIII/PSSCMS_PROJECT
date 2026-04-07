<?php
session_start();

if(!isset($_SESSION['username']) || !isset($_SESSION['logged_in'])) {
    header('Location: ../index.php');
    exit();
}

require_once '../config.php';

if(!isset($_GET['grade']) || !isset($_GET['section'])) {
    header('Location: ../select_grade.php');
    exit();
}

$grade = intval($_GET['grade']);
$section = $_GET['section'];
$table_name = 'tblgrade' . $grade . strtolower($section);
$is_admin = ($_SESSION['usertype'] == 'admin');

// Pagination settings
$records_per_page = 25;
$current_page = isset($_GET['page']) ? intval($_GET['page']) : 1;
$offset = ($current_page - 1) * $records_per_page;

// Search functionality
$search = isset($_GET['search']) ? trim($_GET['search']) : '';
$search_query = '';
$search_param = '';

if(!empty($search)) {
    $search_param = '%' . mysqli_real_escape_string($conn, $search) . '%';
    $search_query = " WHERE lrn_number LIKE ? OR last_name LIKE ? OR first_name LIKE ? OR CONCAT(first_name, ' ', last_name) LIKE ? OR CONCAT(last_name, ' ', first_name) LIKE ?";
}

// Handle Add Student
if(isset($_POST['action']) && $_POST['action'] == 'add' && $is_admin) {
    $lrn = mysqli_real_escape_string($conn, $_POST['lrn_number']);
    $last_name = mysqli_real_escape_string($conn, $_POST['last_name']);
    $first_name = mysqli_real_escape_string($conn, $_POST['first_name']);
    $middle_name = mysqli_real_escape_string($conn, $_POST['middle_name']);
    $age = intval($_POST['age']);
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    $contact = mysqli_real_escape_string($conn, $_POST['contact_number']);
    $parent_name = mysqli_real_escape_string($conn, $_POST['parent_name']);
    $parent_contact = mysqli_real_escape_string($conn, $_POST['parent_contact']);
    
    // Server-side validation
    $validation_error = false;
    
    // Validate LRN (must be exactly 12 digits and numeric)
    if (!ctype_digit($lrn) || strlen($lrn) != 12) {
        $error_message = "LRN must be exactly 12 digits.";
        $validation_error = true;
    }

    // Check for duplicate LRN (Add)
    if (!$validation_error) {
        $check_query = "SELECT id FROM $table_name WHERE lrn_number = ?";
        $check_stmt = mysqli_prepare($conn, $check_query);
        mysqli_stmt_bind_param($check_stmt, "s", $lrn);
        mysqli_stmt_execute($check_stmt);
        mysqli_stmt_store_result($check_stmt);
        if(mysqli_stmt_num_rows($check_stmt) > 0) {
            $error_message = "This LRN number already exists. Please use a unique LRN.";
            $validation_error = true;
        }
        mysqli_stmt_close($check_stmt);
    }

    // Validate age (must be between 1 and 20)
    if (!$validation_error && ($age < 1 || $age > 20)) {
        $error_message = "Age must be between 1 and 20 years old.";
        $validation_error = true;
    }
    
    // Validate contact numbers (must be exactly 11 digits and numeric)
    if (!$validation_error && (!ctype_digit($contact) || strlen($contact) != 11)) {
        $error_message = "Contact number must be exactly 11 digits.";
        $validation_error = true;
    }
    
    if (!$validation_error && (!ctype_digit($parent_contact) || strlen($parent_contact) != 11)) {
        $error_message = "Parent's contact number must be exactly 11 digits.";
        $validation_error = true;
    }
    
    if (!$validation_error) {
        $insert_query = "INSERT INTO $table_name (lrn_number, last_name, first_name, middle_name, age, gender, contact_number, parent_name, parent_contact) 
                         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = mysqli_prepare($conn, $insert_query);
        mysqli_stmt_bind_param($stmt, "ssssissss", $lrn, $last_name, $first_name, $middle_name, $age, $gender, $contact, $parent_name, $parent_contact);
        
        if(mysqli_stmt_execute($stmt)) {
            $success_message = "Student added successfully!";
        } else {
            $error_message = "Error adding student: " . mysqli_error($conn);
        }
        mysqli_stmt_close($stmt);
    }
}

// Handle Edit Student
if(isset($_POST['action']) && $_POST['action'] == 'edit' && $is_admin) {
    $id = intval($_POST['id']);
    $lrn = mysqli_real_escape_string($conn, $_POST['lrn_number']);
    $last_name = mysqli_real_escape_string($conn, $_POST['last_name']);
    $first_name = mysqli_real_escape_string($conn, $_POST['first_name']);
    $middle_name = mysqli_real_escape_string($conn, $_POST['middle_name']);
    $age = intval($_POST['age']);
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    $contact = mysqli_real_escape_string($conn, $_POST['contact_number']);
    $parent_name = mysqli_real_escape_string($conn, $_POST['parent_name']);
    $parent_contact = mysqli_real_escape_string($conn, $_POST['parent_contact']);
    
    // Server-side validation
    $validation_error = false;

    // Validate LRN (must be exactly 12 digits and numeric)
    if (!ctype_digit($lrn) || strlen($lrn) != 12) {
        $error_message = "LRN must be exactly 12 digits.";
        $validation_error = true;
    }

    // Check for duplicate LRN (Edit - exclude current student's ID)
    if (!$validation_error) {
        $check_query = "SELECT id FROM $table_name WHERE lrn_number = ? AND id != ?";
        $check_stmt = mysqli_prepare($conn, $check_query);
        mysqli_stmt_bind_param($check_stmt, "si", $lrn, $id);
        mysqli_stmt_execute($check_stmt);
        mysqli_stmt_store_result($check_stmt);
        if(mysqli_stmt_num_rows($check_stmt) > 0) {
            $error_message = "This LRN number already exists. Please use a unique LRN.";
            $validation_error = true;
        }
        mysqli_stmt_close($check_stmt);
    }
    
    // Validate age (must be between 1 and 20)
    if (!$validation_error && ($age < 1 || $age > 20)) {
        $error_message = "Age must be between 1 and 20 years old.";
        $validation_error = true;
    }
    
    // Validate contact numbers (must be exactly 11 digits and numeric)
    if (!$validation_error && (!ctype_digit($contact) || strlen($contact) != 11)) {
        $error_message = "Contact number must be exactly 11 digits.";
        $validation_error = true;
    }

    if (!$validation_error && (!ctype_digit($parent_contact) || strlen($parent_contact) != 11)) {
        $error_message = "Parent's contact number must be exactly 11 digits.";
        $validation_error = true;
    }
    
    if (!$validation_error) {
        $update_query = "UPDATE $table_name SET lrn_number=?, last_name=?, first_name=?, middle_name=?, age=?, gender=?, contact_number=?, parent_name=?, parent_contact=? WHERE id=?";
        $stmt = mysqli_prepare($conn, $update_query);
        mysqli_stmt_bind_param($stmt, "ssssissssi", $lrn, $last_name, $first_name, $middle_name, $age, $gender, $contact, $parent_name, $parent_contact, $id);
        
        if(mysqli_stmt_execute($stmt)) {
            $success_message = "Student updated successfully!";
        } else {
            $error_message = "Error updating student: " . mysqli_error($conn);
        }
        mysqli_stmt_close($stmt);
    }
}

// Handle Delete
if(isset($_GET['delete']) && $is_admin) {
    $id = intval($_GET['delete']);
    $delete_query = "DELETE FROM $table_name WHERE id = ?";
    $stmt = mysqli_prepare($conn, $delete_query);
    mysqli_stmt_bind_param($stmt, "i", $id);
    if(mysqli_stmt_execute($stmt)) {
        $success_message = "Student deleted successfully!";
    } else {
        $error_message = "Error deleting student.";
    }
    mysqli_stmt_close($stmt);
}

// Count total records for pagination
$count_query = "SELECT COUNT(*) as total FROM $table_name" . $search_query;
if(!empty($search)) {
    $count_stmt = mysqli_prepare($conn, $count_query);
    mysqli_stmt_bind_param($count_stmt, "sssss", $search_param, $search_param, $search_param, $search_param, $search_param);
    mysqli_stmt_execute($count_stmt);
    $count_result = mysqli_stmt_get_result($count_stmt);
    $total_records = mysqli_fetch_assoc($count_result)['total'];
    mysqli_stmt_close($count_stmt);
} else {
    $count_result = mysqli_query($conn, $count_query);
    $total_records = mysqli_fetch_assoc($count_result)['total'];
}

$total_pages = ceil($total_records / $records_per_page);

// Fetch students with pagination
$query = "SELECT * FROM $table_name" . $search_query . " ORDER BY last_name, first_name LIMIT ? OFFSET ?";
$stmt = mysqli_prepare($conn, $query);

if(!empty($search)) {
    mysqli_stmt_bind_param($stmt, "sssssii", $search_param, $search_param, $search_param, $search_param, $search_param, $records_per_page, $offset);
} else {
    mysqli_stmt_bind_param($stmt, "ii", $records_per_page, $offset);
}

mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - Grade <?php echo $grade; ?> <?php echo htmlspecialchars($section); ?></title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="student_list_styles.css">
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <div class="header-left">
                <div class="school-logo-header">
                    <img src="../logo.png" alt="Palatiw Elementary School Logo" onerror="this.style.display='none'">
                </div>
                <div class="school-info">
                    <div class="school-name">Palatiw Elementary School</div>
                    <div class="school-subtitle">Student Management System</div>
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
        <div class="breadcrumb">
            <a href="../select_grade.php"><i class="fas fa-home"></i> Grade Selection</a>
            <span>›</span>
            <a href="../select_section.php?grade=<?php echo $grade; ?>">Grade <?php echo $grade; ?> Sections</a>
            <span>›</span>
            <span class="current"><?php echo htmlspecialchars($section); ?> - Student List</span>
        </div>

        <!-- Back Button -->
        <button class="back-btn" onclick="location.href='../select_section.php?grade=<?php echo $grade; ?>'">
            <i class="fas fa-arrow-left"></i> Back to Sections
        </button>

        <!-- Alerts -->
        <?php if(isset($success_message)): ?>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <?php echo $success_message; ?>
            </div>
        <?php endif; ?>

        <?php if(isset($error_message)): ?>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <?php echo $error_message; ?>
            </div>
        <?php endif; ?>

        <!-- Page Header -->
        <div class="page-header">
            <div class="page-header-content">
                <div>
                    <h1 class="page-title">
                        <i class="fas fa-users"></i>
                        Grade <?php echo $grade; ?> - <?php echo htmlspecialchars($section); ?>
                    </h1>
                    <p class="page-description">Manage student records and information</p>
                </div>
                <?php if($is_admin): ?>
                    <button class="btn-add" onclick="openAddModal()">
                        <i class="fas fa-plus"></i>
                        Add New Student
                    </button>
                <?php endif; ?>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="search-section">
            <form method="GET" action="">
                <input type="hidden" name="grade" value="<?php echo $grade; ?>">
                <input type="hidden" name="section" value="<?php echo htmlspecialchars($section); ?>">
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
                        <button type="button" class="btn-clear" onclick="clearSearch()">
                            <i class="fas fa-times"></i> Clear
                        </button>
                    <?php endif; ?>
                </div>
            </form>
            <?php if(!empty($search)): ?>
                <div class="search-info">
                    <i class="fas fa-info-circle"></i> 
                    Showing results for: <strong>"<?php echo htmlspecialchars($search); ?>"</strong> 
                    (<?php echo $total_records; ?> record<?php echo $total_records != 1 ? 's' : ''; ?> found)
                </div>
            <?php endif; ?>
        </div>

        <!-- Table -->
        <div class="table-section">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>LRN Number</th>
                            <th>Last Name</th>
                            <th>First Name</th>
                            <th>Middle Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Contact</th>
                            <th>Parent Name</th>
                            <th>Parent Contact</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if(mysqli_num_rows($result) > 0): ?>
                            <?php while($row = mysqli_fetch_assoc($result)): ?>
                                <tr>
                                    <td><span class="lrn-badge"><?php echo htmlspecialchars($row['lrn_number']); ?></span></td>
                                    <td><strong><?php echo htmlspecialchars($row['last_name']); ?></strong></td>
                                    <td><?php echo htmlspecialchars($row['first_name']); ?></td>
                                    <td><?php echo htmlspecialchars($row['middle_name']); ?></td>
                                    <td><?php echo htmlspecialchars($row['age']); ?></td>
                                    <td><?php echo htmlspecialchars($row['gender']); ?></td>
                                    <td><?php echo htmlspecialchars($row['contact_number']); ?></td>
                                    <td><?php echo htmlspecialchars($row['parent_name']); ?></td>
                                    <td><?php echo htmlspecialchars($row['parent_contact']); ?></td>
                                    <td>
                                        <div class="action-buttons">
                                            <button class="btn-view" onclick='viewStudent(<?php echo htmlspecialchars(json_encode($row), ENT_QUOTES, "UTF-8"); ?>)' title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <?php if($is_admin): ?>
                                                <button class="btn-edit" onclick='editStudent(<?php echo htmlspecialchars(json_encode($row), ENT_QUOTES, "UTF-8"); ?>)' title="Edit Student">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn-delete" onclick="deleteStudent(<?php echo $row['id']; ?>, '<?php echo htmlspecialchars($row['first_name'] . ' ' . $row['last_name'], ENT_QUOTES, 'UTF-8'); ?>')" title="Delete Student">
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
                                    <i class="fas fa-users-slash"></i>
                                    <p><?php echo !empty($search) ? 'No students found matching your search.' : 'No students found in this section.'; ?></p>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Pagination -->
        <?php if($total_pages > 1): ?>
        <div class="pagination-container">
            <div class="pagination-info">
                Showing <strong><?php echo $offset + 1; ?></strong> to <strong><?php echo min($offset + $records_per_page, $total_records); ?></strong> of <strong><?php echo $total_records; ?></strong> students
            </div>
            <ul class="pagination">
                <?php
                $base_url = "?grade=$grade&section=" . urlencode($section);
                if(!empty($search)) {
                    $base_url .= "&search=" . urlencode($search);
                }
                ?>
                
                <?php if($current_page > 1): ?>
                    <li><a href="<?php echo $base_url; ?>&page=1" title="First Page"><i class="fas fa-angle-double-left"></i></a></li>
                    <li><a href="<?php echo $base_url; ?>&page=<?php echo $current_page - 1; ?>" title="Previous Page"><i class="fas fa-angle-left"></i></a></li>
                <?php else: ?>
                    <li><span class="disabled"><i class="fas fa-angle-double-left"></i></span></li>
                    <li><span class="disabled"><i class="fas fa-angle-left"></i></span></li>
                <?php endif; ?>

                <?php
                $start_page = max(1, $current_page - 2);
                $end_page = min($total_pages, $current_page + 2);
                
                for($i = $start_page; $i <= $end_page; $i++):
                ?>
                    <li>
                        <?php if($i == $current_page): ?>
                            <span class="active"><?php echo $i; ?></span>
                        <?php else: ?>
                            <a href="<?php echo $base_url; ?>&page=<?php echo $i; ?>"><?php echo $i; ?></a>
                        <?php endif; ?>
                    </li>
                <?php endfor; ?>

                <?php if($current_page < $total_pages): ?>
                    <li><a href="<?php echo $base_url; ?>&page=<?php echo $current_page + 1; ?>" title="Next Page"><i class="fas fa-angle-right"></i></a></li>
                    <li><a href="<?php echo $base_url; ?>&page=<?php echo $total_pages; ?>" title="Last Page"><i class="fas fa-angle-double-right"></i></a></li>
                <?php else: ?>
                    <li><span class="disabled"><i class="fas fa-angle-right"></i></span></li>
                    <li><span class="disabled"><i class="fas fa-angle-double-right"></i></span></li>
                <?php endif; ?>
            </ul>
        </div>
        <?php endif; ?>
    </div>

    <!-- Add/Edit Modal -->
    <div id="studentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle"><i class="fas fa-user-plus"></i> Add New Student</h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="studentForm" method="POST">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="id" id="studentId">
                
                <div class="modal-body">
                    <div class="form-grid">
                        <div class="form-group full-width">
                            <label for="lrn_number">LRN Number <span class="required">*</span></label>
                            <input type="text" id="lrn_number" name="lrn_number" placeholder="12-digit LRN" maxlength="12" oninput="validateLRN(this)" required>
                        </div>
                        <div class="form-group">
                            <label for="last_name">Last Name <span class="required">*</span></label>
                            <input type="text" id="last_name" name="last_name" required>
                        </div>
                        <div class="form-group">
                            <label for="first_name">First Name <span class="required">*</span></label>
                            <input type="text" id="first_name" name="first_name" required>
                        </div>
                        <div class="form-group">
                            <label for="middle_name">Middle Name <span class="required">*</span></label>
                            <input type="text" id="middle_name" name="middle_name" required>
                        </div>
                        <div class="form-group">
                            <label for="age">Age <span class="required">*</span></label>
                            <input type="number" id="age" name="age" min="1" max="20" maxlength="2" oninput="validateAge(this)" required>
                        </div>
                        <div class="form-group">
                            <label for="gender">Gender <span class="required">*</span></label>
                            <select id="gender" name="gender" required>
                                <option value="">Select Gender</option>
                                <option value="MALE">MALE</option>
                                <option value="FEMALE">FEMALE</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="contact_number">Contact Number <span class="required">*</span></label>
                            <input type="text" id="contact_number" name="contact_number" placeholder="09XXXXXXXXX" maxlength="11" oninput="validateContactNumber(this)" required>
                        </div>
                        <div class="form-group">
                            <label for="parent_name">Parent's Name <span class="required">*</span></label>
                            <input type="text" id="parent_name" name="parent_name" required>
                        </div>
                        <div class="form-group full-width">
                            <label for="parent_contact">Parent's Contact Number <span class="required">*</span></label>
                            <input type="text" id="parent_contact" name="parent_contact" placeholder="09XXXXXXXXX" maxlength="11" oninput="validateContactNumber(this)" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> Save Student
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- View Modal -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-user"></i> Student Details</h2>
                <span class="close" onclick="closeViewModal()">&times;</span>
            </div>
            <div class="modal-body" id="viewModalBody">
                <!-- Content will be populated by JavaScript -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="closeViewModal()">Close</button>
            </div>
        </div>
    </div>

    <script src="student_list_scripts.js"></script>
</body>
</html>
<?php
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>