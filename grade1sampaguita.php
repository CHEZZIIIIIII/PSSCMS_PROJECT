<?php
session_start();

// Check if user is logged in (allow both admin and teacher)
if(!isset($_SESSION['username']) || !isset($_SESSION['logged_in'])) {
    header('Location: index.php');
    exit();
}

require_once 'config.php';

$grade = 1;
$section = 'Sampaguita';
$is_admin = ($_SESSION['usertype'] == 'admin');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grade 1 - Sampaguita - Palatiw Elementary</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #2c5f7c 0%, #1a4d6b 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .main-container {
            max-width: 1100px;
            width: 100%;
        }
        
        .top-bar {
            background: linear-gradient(135deg, #ff9933 0%, #ff8c1a 100%);
            padding: 15px 30px;
            border-radius: 15px 15px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        
        .back-btn {
            background: white;
            color: #ff9933;
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 700;
            transition: all 0.3s;
            text-transform: uppercase;
        }
        
        .back-btn:hover {
            background: #f0f0f0;
            transform: scale(1.05);
        }
        
        .page-title {
            color: white;
            font-size: 28px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .logout-btn {
            background: #c62828;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 700;
            transition: all 0.3s;
            text-transform: uppercase;
        }
        
        .logout-btn:hover {
            background: #d32f2f;
            transform: scale(1.05);
        }
        
        .content-container {
            background: white;
            padding: 50px;
            border-radius: 0 0 15px 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        
        .header-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .logo-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
            flex-shrink: 0;
        }
        
        .logo-circle img {
            width: 60px;
            height: 60px;
            object-fit: contain;
        }
        
        .header-text {
            flex: 1;
        }
        
        .system-title {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            display: inline-block;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .welcome-text {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            display: inline-block;
            font-size: 13px;
            font-weight: 600;
        }
        
        .folders-section {
            text-align: center;
        }
        
        .section-heading {
            color: #2c3e50;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
            text-transform: uppercase;
        }
        
        .section-subtitle {
            color: #666;
            font-size: 14px;
            font-style: italic;
            margin-bottom: 40px;
        }
        
        .folders-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 40px;
            max-width: 700px;
            margin: 0 auto;
        }
        
        .folder-item {
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .folder-item:hover {
            transform: translateY(-10px);
        }
        
        .folder-icon-wrapper {
            background: linear-gradient(135deg, #4a90a4 0%, #357a8c 100%);
            width: 150px;
            height: 150px;
            margin: 0 auto 20px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }
        
        .folder-item:hover .folder-icon-wrapper {
            box-shadow: 0 8px 30px rgba(0,0,0,0.25);
        }
        
        .folder-icon-wrapper i {
            font-size: 70px;
            color: white;
        }
        
        .folder-label {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            padding: 12px 30px;
            border-radius: 30px;
            display: inline-block;
            font-size: 15px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
            transition: all 0.3s;
        }
        
        .folder-item:hover .folder-label {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0,0,0,0.25);
        }
        
        @media (max-width: 768px) {
            .top-bar {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .content-container {
                padding: 30px 20px;
            }
            
            .header-section {
                flex-direction: column;
                text-align: center;
            }
            
            .folders-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }
            
            .page-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="top-bar">
            <button class="back-btn" onclick="location.href='select_section.php?grade=1'">
                <i class="fas fa-arrow-left"></i> Back
            </button>
            <div class="page-title">Grade 1 - Sampaguita</div>
            <button class="logout-btn" onclick="location.href='logout.php'">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
        
        <div class="content-container">
            <div class="header-section">
                <div class="logo-circle">
                    <img src="logo.png" alt="Logo" onerror="this.src='https://via.placeholder.com/60/0d4d4d/ffffff?text=Logo'">
                </div>
                <div class="header-text">
                    <div class="system-title">
                        PALATIW SCHOOL SUPPLY CONSOLIDATION AND MANAGEMENT SYSTEM
                    </div>
                    <div class="welcome-text">
                        WELCOME ADMINISTRATOR, <?php echo strtoupper(htmlspecialchars($_SESSION['username'])); ?>
                    </div>
                </div>
            </div>
            
            <div class="folders-section">
                <h2 class="section-heading">Choose File to Open:</h2>
                <p class="section-subtitle">Select a folder to proceed.</p>
                
                <div class="folders-grid">
                    <div class="folder-item" onclick="location.href='students_list.php?grade=<?php echo $grade; ?>&section=<?php echo urlencode($section); ?>'">
                        <div class="folder-icon-wrapper">
                            <i class="fas fa-folder"></i>
                        </div>
                        <div class="folder-label">Students List</div>
                    </div>
                    
                    <div class="folder-item" onclick="location.href='students_supplies.php?grade=<?php echo $grade; ?>&section=<?php echo urlencode($section); ?>'">
                        <div class="folder-icon-wrapper">
                            <i class="fas fa-folder"></i>
                        </div>
                        <div class="folder-label">Students Supplies</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<?php
mysqli_close($conn);
?>