<?php
session_start();

// Check if user is logged in (allow both admin and teacher)
if(!isset($_SESSION['username']) || !isset($_SESSION['logged_in'])) {
    header('Location: index.php');
    exit();
}

require_once 'config.php';

if(!isset($_GET['grade'])) {
    header('Location: select_grade.php');
    exit();
}

$grade = intval($_GET['grade']);
$is_admin = ($_SESSION['usertype'] == 'admin');

// Fetch sections for the selected grade from tblsections
$query = "SELECT section FROM tblsections WHERE grade = ? ORDER BY section";
$stmt = mysqli_prepare($conn, $query);
mysqli_stmt_bind_param($stmt, "i", $grade);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Section - Palatiw Elementary</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: #f8fafb;
            min-height: 100vh;
            color: #1e293b;
        }
        
        /* Header Styles */
        .header {
            background: linear-gradient(135deg, #004643 0%, #006b66 100%);
            color: white;
            padding: 24px 48px;
            box-shadow: 0 4px 20px rgba(0, 70, 67, 0.15);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .school-logo-header {
            width: 70px;
            height: 70px;
            background: white;
            border-radius: 16px;
            padding: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        .school-logo-header img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .school-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .school-name {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: -0.5px;
            line-height: 1.2;
        }

        .school-subtitle {
            font-size: 14px;
            opacity: 0.9;
            font-weight: 400;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-info {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 4px;
        }

        .user-greeting {
            font-size: 14px;
            opacity: 0.9;
        }

        .user-name-badge {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .user-name {
            font-size: 16px;
            font-weight: 600;
        }

        .user-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .header-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-dashboard, .btn-logout {
            border: none;
            padding: 10px 24px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-dashboard {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-dashboard:hover {
            background: rgba(255, 255, 255, 0.25);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
        }

        .btn-logout {
            background: rgba(239, 68, 68, 0.9);
            color: white;
        }

        .btn-logout:hover {
            background: rgba(220, 38, 38, 1);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 48px;
        }
        
        /* Breadcrumb */
        .breadcrumb {
            background: white;
            padding: 16px 24px;
            border-radius: 12px;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            border: 1px solid #f1f5f9;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        
        .breadcrumb a {
            color: #004643;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
            font-size: 14px;
        }
        
        .breadcrumb a:hover {
            color: #006b66;
        }
        
        .breadcrumb span {
            color: #cbd5e1;
            font-weight: 600;
        }
        
        .breadcrumb .current {
            color: #64748b;
            font-weight: 600;
            font-size: 14px;
        }
        
        /* Back Button */
        .back-btn {
            background: white;
            color: #475569;
            border: 2px solid #e2e8f0;
            padding: 12px 24px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 24px;
        }
        
        .back-btn:hover {
            background: #f8fafc;
            border-color: #004643;
            color: #004643;
            transform: translateX(-4px);
        }
        
        /* Welcome Section */
        .welcome-section {
            background: white;
            padding: 36px 40px;
            border-radius: 20px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
            border: 1px solid #f1f5f9;
            margin-bottom: 40px;
            text-align: center;
        }
        
        .welcome-section h2 {
            font-size: 28px;
            color: #1e293b;
            margin-bottom: 8px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .welcome-section h2 i {
            color: #004643;
            font-size: 32px;
        }
        
        .welcome-section p {
            color: #64748b;
            font-size: 15px;
            font-weight: 400;
        }
        
        /* Folder Grid */
        .folder-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 24px;
        }
        
        .folder-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
            border: 1px solid #f1f5f9;
            cursor: pointer;
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
        }

        .folder-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #004643, #006b66);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        
        .folder-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 32px rgba(0, 70, 67, 0.15);
            border-color: #004643;
        }

        .folder-card:hover::before {
            transform: scaleX(1);
        }
        
        .folder-icon {
            background: linear-gradient(135deg, #004643 0%, #006b66 100%);
            padding: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .folder-icon::after {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 80px;
            height: 80px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            border-radius: 50%;
        }
        
        .folder-icon i {
            font-size: 48px;
            color: white;
            position: relative;
            z-index: 1;
            transition: transform 0.3s ease;
        }

        .folder-card:hover .folder-icon i {
            transform: scale(1.1);
        }
        
        .folder-info {
            padding: 24px 20px;
            text-align: center;
            background: white;
        }
        
        .folder-name {
            font-size: 20px;
            font-weight: 700;
            color: #004643;
            margin-bottom: 4px;
        }
        
        .folder-label {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* No Sections Message */
        .no-sections {
            background: white;
            border: 2px dashed #e2e8f0;
            color: #64748b;
            padding: 60px 40px;
            border-radius: 20px;
            text-align: center;
            margin-top: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 16px;
        }
        
        .no-sections i {
            font-size: 64px;
            color: #cbd5e1;
        }

        .no-sections strong {
            color: #1e293b;
            font-size: 18px;
            font-weight: 600;
        }

        .no-sections p {
            font-size: 14px;
            color: #64748b;
            max-width: 500px;
        }
        
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: white;
            margin: 5% auto;
            padding: 0;
            border-radius: 24px;
            width: 90%;
            max-width: 540px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.3s ease;
            overflow: hidden;
        }

        @keyframes slideUp {
            from {
                transform: translateY(40px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .modal-header {
            background: linear-gradient(135deg, #004643 0%, #006b66 100%);
            color: white;
            padding: 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 24px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .close {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 28px;
            cursor: pointer;
            transition: all 0.3s ease;
            border-radius: 8px;
        }

        .close:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(90deg);
        }

        .modal-body {
            padding: 32px;
        }

        .option-buttons {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .option-btn {
            background: white;
            border: 2px solid #e2e8f0;
            padding: 24px;
            border-radius: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 20px;
            text-align: left;
        }

        .option-btn:hover {
            border-color: #004643;
            background: #f8fafc;
            transform: translateX(8px);
            box-shadow: 0 4px 16px rgba(0, 70, 67, 0.1);
        }

        .option-icon {
            width: 68px;
            height: 68px;
            background: linear-gradient(135deg, #004643 0%, #006b66 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            box-shadow: 0 4px 12px rgba(0, 70, 67, 0.2);
        }

        .option-icon i {
            font-size: 32px;
            color: white;
        }

        .option-text h3 {
            color: #1e293b;
            margin-bottom: 6px;
            font-size: 18px;
            font-weight: 700;
        }

        .option-text p {
            color: #64748b;
            font-size: 14px;
            margin: 0;
            line-height: 1.5;
        }
        
        /* Responsive Design */
        @media (max-width: 1400px) {
            .folder-grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }
        
        @media (max-width: 1024px) {
            .folder-grid {
                grid-template-columns: repeat(3, 1fr);
            }

            .container {
                padding: 32px 24px;
            }

            .header {
                padding: 20px 24px;
            }
        }
        
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
            }
            
            .header-left {
                flex-direction: column;
                gap: 16px;
                text-align: center;
            }

            .school-info {
                align-items: center;
            }

            .school-name {
                font-size: 22px;
            }
            
            .header-right {
                flex-direction: column;
                gap: 16px;
                width: 100%;
            }
            
            .user-info {
                align-items: center;
            }

            .header-buttons {
                width: 100%;
                flex-direction: column;
            }

            .btn-dashboard, .btn-logout {
                width: 100%;
                justify-content: center;
            }
            
            .folder-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }
            
            .breadcrumb {
                font-size: 13px;
            }

            .modal-content {
                margin: 10% 20px;
            }

            .option-btn {
                flex-direction: column;
                text-align: center;
                padding: 20px;
            }

            .welcome-section {
                padding: 28px 24px;
            }

            .welcome-section h2 {
                font-size: 24px;
                flex-direction: column;
                gap: 8px;
            }
        }
        
        @media (max-width: 480px) {
            .container {
                padding: 24px 16px;
            }

            .header {
                padding: 16px;
            }

            .school-logo-header {
                width: 56px;
                height: 56px;
            }

            .school-name {
                font-size: 20px;
            }

            .school-subtitle {
                font-size: 12px;
            }

            .folder-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .modal-content {
                width: 95%;
            }

            .modal-header {
                padding: 24px;
            }

            .modal-header h2 {
                font-size: 20px;
            }

            .modal-body {
                padding: 24px;
            }

            .welcome-section h2 {
                font-size: 20px;
            }

            .welcome-section p {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="header-content">
            <div class="header-left">
                <div class="school-logo-header">
                    <img src="logo.png" alt="Palatiw Elementary School Logo" onerror="this.style.display='none'">
                </div>
                <div class="school-info">
                    <div class="school-name">Palatiw Elementary School</div>
                    <div class="school-subtitle">Supply Consolidation and Management System</div>
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
                <div class="header-buttons">
                    <?php if($is_admin): ?>
                        <button class="btn-dashboard" onclick="location.href='admin_dashboard.php'">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </button>
                    <?php endif; ?>
                    <button class="btn-logout" onclick="location.href='logout.php'">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Main Container -->
    <div class="container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <?php if($is_admin): ?>
                <a href="admin_dashboard.php">
                    <i class="fas fa-tachometer-alt"></i>
                    Dashboard
                </a>
                <span>›</span>
            <?php endif; ?>
            <a href="select_grade.php">
                <i class="fas fa-home"></i>
                Grade Selection
            </a>
            <span>›</span>
            <span class="current">Grade <?php echo $grade; ?> - Sections</span>
        </div>
        
        <!-- Back Button -->
        <button class="back-btn" onclick="location.href='select_grade.php'">
            <i class="fas fa-arrow-left"></i>
            Back to Grades
        </button>
        
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2>
                <i class="fas fa-folder-open"></i>
                Grade <?php echo $grade; ?> Sections
            </h2>
            <p><?php echo $is_admin ? 'Admin: View and manage all sections' : 'Select a section to view students or manage supplies'; ?></p>
        </div>
        
        <!-- Folder Grid -->
        <div class="folder-grid">
            <?php 
            $has_sections = false;
            while($row = mysqli_fetch_assoc($result)): 
                $has_sections = true;
                $section = $row['section'];
            ?>
                <div class="folder-card" onclick="openModal('<?php echo htmlspecialchars($section); ?>', <?php echo $grade; ?>)">
                    <div class="folder-icon">
                        <i class="fas fa-folder"></i>
                    </div>
                    <div class="folder-info">
                        <div class="folder-name"><?php echo htmlspecialchars($section); ?></div>
                        <div class="folder-label">Section</div>
                    </div>
                </div>
            <?php endwhile; ?>
        </div>
        
        <!-- No Sections Message -->
        <?php if(!$has_sections): ?>
            <div class="no-sections">
                <i class="fas fa-folder-open"></i>
                <p><strong>No sections found for Grade <?php echo $grade; ?></strong></p>
                <p><?php echo $is_admin ? 'You can add sections through the database or section management.' : 'Please contact the administrator to add sections.'; ?></p>
            </div>
        <?php endif; ?>
    </div>

    <!-- Modal -->
    <div id="sectionModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2><i class="fas fa-folder-open"></i> <span id="modalSectionName"></span></h2>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <div class="modal-body">
                <div class="option-buttons">
                    <div class="option-btn" onclick="goToStudentList()">
                        <div class="option-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="option-text">
                            <h3>Student List</h3>
                            <p>View and manage students in this section</p>
                        </div>
                    </div>
                    <div class="option-btn" onclick="goToSupplies()">
                        <div class="option-icon">
                            <i class="fas fa-boxes"></i>
                        </div>
                        <div class="option-text">
                            <h3>School Supplies & Uniforms</h3>
                            <p>Manage supplies and uniform requirements</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let currentSection = '';
        let currentGrade = 0;

        function openModal(section, grade) {
            currentSection = section;
            currentGrade = grade;
            document.getElementById('modalSectionName').textContent = 'Grade ' + grade + ' - ' + section;
            document.getElementById('sectionModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('sectionModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }

        function goToStudentList() {
            const fileName = currentSection.toLowerCase() + '_student_list.php';
            const folderName = 'Grade' + currentGrade;
            window.location.href = folderName + '/' + fileName + '?grade=' + currentGrade + '&section=' + encodeURIComponent(currentSection);
        }

        function goToSupplies() {
            const fileName = currentSection.toLowerCase() + '_supplies.php';
            const folderName = 'Grade' + currentGrade;
            window.location.href = folderName + '/' + fileName + '?grade=' + currentGrade + '&section=' + encodeURIComponent(currentSection);
        }

        window.onclick = function(event) {
            const modal = document.getElementById('sectionModal');
            if (event.target == modal) {
                closeModal();
            }
        }

        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });
    </script>
</body>
</html>
<?php
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>