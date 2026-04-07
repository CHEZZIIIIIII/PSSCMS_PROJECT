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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f5f5 0%, #e0e0e0 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .header {
            background: white;
            padding: 20px 40px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .logo {
            width: 50px;
            height: 50px;
        }
        
        .logo img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        
        .header-title h1 {
            color: #0d4d4d;
            font-size: 24px;
        }
        
        .header-title p {
            color: #666;
            font-size: 13px;
        }
        
        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .user-info {
            text-align: right;
        }
        
        .user-info p {
            color: #0d4d4d;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .user-badge {
            display: inline-block;
            background: #0d4d4d;
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            margin-left: 8px;
        }

        .btn-dashboard {
            background: #666;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s;
            margin-right: 10px;
        }

        .btn-dashboard:hover {
            background: #555;
        }
        
        .logout-btn {
            background: #c62828;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s;
        }
        
        .logout-btn:hover {
            background: #d32f2f;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .breadcrumb {
            background: white;
            padding: 15px 30px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .breadcrumb a {
            color: #0d4d4d;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .breadcrumb a:hover {
            color: #1a6b6b;
        }
        
        .breadcrumb span {
            color: #999;
        }
        
        .breadcrumb .current {
            color: #666;
            font-weight: 600;
        }
        
        .back-btn {
            background: #666;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }
        
        .back-btn:hover {
            background: #555;
        }
        
        .welcome-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        
        .welcome-section h2 {
            color: #0d4d4d;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .welcome-section p {
            color: #666;
        }
        
        .folder-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            margin-top: 20px;
        }
        
        .folder-card {
            background: white;
            padding: 0;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            cursor: pointer;
            transition: all 0.3s;
            overflow: hidden;
            border: 2px solid transparent;
        }
        
        .folder-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            border-color: #0d4d4d;
        }
        
        .folder-icon {
            background: linear-gradient(135deg, #0d4d4d 0%, #1a6b6b 100%);
            padding: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .folder-icon i {
            font-size: 40px;
            color: white;
        }
        
        .folder-info {
            padding: 18px;
            text-align: center;
        }
        
        .folder-name {
            font-size: 20px;
            font-weight: bold;
            color: #0d4d4d;
            margin-bottom: 5px;
        }
        
        .folder-label {
            font-size: 13px;
            color: #666;
            font-weight: 500;
        }
        
        .no-sections {
            background: #fff3cd;
            color: #856404;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }
        
        .no-sections i {
            font-size: 48px;
            color: #f0ad4e;
        }
        
        @media (max-width: 1400px) {
            .folder-grid {
                grid-template-columns: repeat(4, 1fr);
            }
        }
        
        @media (max-width: 1024px) {
            .folder-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .header-left {
                flex-direction: column;
            }

            .header-right {
                flex-direction: column;
            }
            
            .user-info {
                text-align: center;
            }
            
            .folder-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .breadcrumb {
                flex-wrap: wrap;
            }
        }
        
        @media (max-width: 480px) {
            .folder-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <div class="logo">
                    <img src="logo.png" alt="Logo" onerror="this.style.display='none'">
                </div>
                <div class="header-title">
                    <h1>Palatiw Elementary</h1>
                    <p>Supply Consolidation and Management System</p>
                </div>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <p>
                        Welcome, <?php echo htmlspecialchars($_SESSION['username']); ?>!
                        <span class="user-badge"><?php echo strtoupper($_SESSION['usertype']); ?></span>
                    </p>
                </div>
                <?php if($is_admin): ?>
                    <button class="btn-dashboard" onclick="location.href='admin_dashboard.php'">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </button>
                <?php endif; ?>
                <button class="logout-btn" onclick="location.href='logout.php'">Logout</button>
            </div>
        </div>
        
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
        
        <button class="back-btn" onclick="location.href='select_grade.php'">
            <i class="fas fa-arrow-left"></i>
            Back to Grades
        </button>
        
        <div class="welcome-section">
            <h2>
                <i class="fas fa-folder-open"></i>
                Grade <?php echo $grade; ?> Sections
            </h2>
            <p><?php echo $is_admin ? 'Admin: View and manage all sections' : 'Select a section to manage school supplies'; ?></p>
        </div>
        
        <div class="folder-grid">
            <?php 
            $has_sections = false;
            while($row = mysqli_fetch_assoc($result)): 
                $has_sections = true;
            ?>
                <?php
                    $section_lower = strtolower($row['section']);
                    $section_page = "section_page.php?grade={$grade}&section=" . urlencode($row['section']);
                ?>
                <div class="folder-card" onclick="location.href='<?php echo $section_page; ?>'">
                    <div class="folder-icon">
                        <i class="fas fa-folder"></i>
                    </div>
                    <div class="folder-info">
                        <div class="folder-name"><?php echo htmlspecialchars($row['section']); ?></div>
                        <div class="folder-label">Section</div>
                    </div>
                </div>
            <?php endwhile; ?>
        </div>
        
        <?php if(!$has_sections): ?>
            <div class="no-sections">
                <i class="fas fa-folder-open"></i>
                <p><strong>No sections found for Grade <?php echo $grade; ?></strong></p>
                <p><?php echo $is_admin ? 'You can add sections through the database or section management.' : 'Please contact the administrator to add sections.'; ?></p>
            </div>
        <?php endif; ?>
    </div>
</body>
</html>
<?php
mysqli_stmt_close($stmt);
mysqli_close($conn);
?>