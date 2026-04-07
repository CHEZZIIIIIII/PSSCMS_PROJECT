<?php
session_start();

// Check if user is logged in (allow both admin and teacher)
if(!isset($_SESSION['username']) || !isset($_SESSION['logged_in'])) {
    header('Location: index.php');
    exit();
}

require_once 'config.php';

// Get user type for display purposes
$is_admin = ($_SESSION['usertype'] == 'admin');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Grade Level - Palatiw Elementary</title>
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
            flex-wrap: wrap;
        }

        .btn-header {
            border: none;
            padding: 10px 20px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            white-space: nowrap;
        }

        .btn-back {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.25);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
        }

        /* Summary dropdown button */
        .btn-summary-wrap {
            position: relative;
        }

        .btn-summary {
            background: rgba(255, 255, 255, 0.18);
            backdrop-filter: blur(10px);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.4);
        }

        .btn-summary:hover {
            background: rgba(255, 255, 255, 0.28);
            border-color: rgba(255, 255, 255, 0.6);
            transform: translateY(-2px);
        }

        .btn-summary .chevron {
            font-size: 10px;
            transition: transform 0.25s;
        }

        .btn-summary-wrap.open .chevron {
            transform: rotate(180deg);
        }

        .summary-dropdown {
            display: none;
            position: absolute;
            top: calc(100% + 10px);
            right: 0;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.16);
            border: 1px solid #e2e8f0;
            min-width: 220px;
            overflow: hidden;
            z-index: 200;
        }

        .btn-summary-wrap.open .summary-dropdown {
            display: block;
            animation: dropIn 0.18s ease;
        }

        @keyframes dropIn {
            from { opacity: 0; transform: translateY(-8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .dropdown-header {
            background: #f8fafc;
            padding: 10px 16px;
            font-size: 10px;
            font-weight: 800;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            border-bottom: 1px solid #f1f5f9;
        }

        .dropdown-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 13px 16px;
            text-decoration: none;
            color: #1e293b;
            font-size: 14px;
            font-weight: 600;
            transition: background 0.15s;
            border-bottom: 1px solid #f8fafc;
        }

        .dropdown-item:last-child {
            border-bottom: none;
        }

        .dropdown-item:hover {
            background: #f0fdfa;
        }

        .dropdown-item-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            flex-shrink: 0;
        }

        .dropdown-item-text {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .dropdown-item-label {
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
        }

        .dropdown-item-desc {
            font-size: 11px;
            color: #94a3b8;
            font-weight: 400;
        }

        .btn-logout {
            background: rgba(239, 68, 68, 0.9);
            color: white;
            border: 2px solid transparent;
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
            grid-template-columns: repeat(3, 1fr);
            gap: 28px;
            max-width: 1200px;
            margin: 0 auto;
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
            padding: 48px;
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
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            border-radius: 50%;
        }
        
        .folder-icon i {
            font-size: 72px;
            color: white;
            position: relative;
            z-index: 1;
            transition: transform 0.3s ease;
        }

        .folder-card:hover .folder-icon i {
            transform: scale(1.1);
        }
        
        .folder-info {
            padding: 32px 24px;
            text-align: center;
            background: white;
        }
        
        .folder-name {
            font-size: 56px;
            font-weight: 800;
            color: #004643;
            margin-bottom: 8px;
            line-height: 1;
        }
        
        .folder-label {
            font-size: 16px;
            color: #64748b;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        /* Responsive Design */
        @media (max-width: 1024px) {
            .container { padding: 32px 24px; }
            .header { padding: 20px 24px; }
            .folder-grid { gap: 24px; }
        }

        @media (max-width: 768px) {
            .header-content { flex-direction: column; gap: 20px; }
            .header-left { flex-direction: column; gap: 16px; text-align: center; }
            .school-info { align-items: center; }
            .school-name { font-size: 22px; }
            .header-right { flex-direction: column; gap: 16px; width: 100%; }
            .user-info { align-items: center; }
            .header-buttons { width: 100%; justify-content: center; }
            .btn-header { flex: 1; justify-content: center; }
            .folder-grid { grid-template-columns: repeat(2, 1fr); gap: 20px; }
            .folder-icon { padding: 36px; }
            .folder-icon i { font-size: 56px; }
            .folder-name { font-size: 48px; }
            .welcome-section { padding: 28px 24px; }
            .welcome-section h2 { font-size: 24px; flex-direction: column; gap: 8px; }
            .summary-dropdown { right: auto; left: 0; }
        }
        
        @media (max-width: 480px) {
            .container { padding: 24px 16px; }
            .header { padding: 16px; }
            .school-logo-header { width: 56px; height: 56px; }
            .school-name { font-size: 20px; }
            .school-subtitle { font-size: 12px; }
            .folder-grid { grid-template-columns: 1fr; gap: 16px; }
            .folder-icon { padding: 32px; }
            .folder-icon i { font-size: 48px; }
            .folder-info { padding: 24px 20px; }
            .folder-name { font-size: 42px; }
            .folder-label { font-size: 14px; }
            .welcome-section h2 { font-size: 20px; }
            .welcome-section p { font-size: 14px; }
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
                        <a href="admin_dashboard.php" class="btn-header btn-back">
                            <i class="fas fa-arrow-left"></i>
                            Dashboard
                        </a>
                    <?php endif; ?>

                    <!-- Summary Dropdown -->
                    <div class="btn-summary-wrap" id="summaryWrap">
                        <button class="btn-header btn-summary" onclick="toggleSummary(event)">
                            <i class="fas fa-chart-bar"></i>
                            Summaries
                            <i class="fas fa-chevron-down chevron"></i>
                        </button>
                        <div class="summary-dropdown">
                            <div class="dropdown-header">View Summaries</div>
                            <a href="student_summary.php" class="dropdown-item">
                                <div class="dropdown-item-icon" style="background:#e0f2fe;color:#0284c7;">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="dropdown-item-text">
                                    <div class="dropdown-item-label">Student Summary</div>
                                    <div class="dropdown-item-desc">Enrollment per grade &amp; section</div>
                                </div>
                            </a>
                            <a href="supplies_summary.php" class="dropdown-item">
                                <div class="dropdown-item-icon" style="background:#fef9c3;color:#854d0e;">
                                    <i class="fas fa-boxes"></i>
                                </div>
                                <div class="dropdown-item-text">
                                    <div class="dropdown-item-label">Supplies Summary</div>
                                    <div class="dropdown-item-desc">School supplies overview</div>
                                </div>
                            </a>
                            <a href="uniform_summary.php" class="dropdown-item">
                                <div class="dropdown-item-icon" style="background:#ede9fe;color:#7c3aed;">
                                    <i class="fas fa-tshirt"></i>
                                </div>
                                <div class="dropdown-item-text">
                                    <div class="dropdown-item-label">Uniform Summary</div>
                                    <div class="dropdown-item-desc">Uniform records overview</div>
                                </div>
                            </a>
                        </div>
                    </div>

                    <button class="btn-header btn-logout" onclick="location.href='logout.php'">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Main Container -->
    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2>
                <i class="fas fa-folder-open"></i>
                Select Grade Level
            </h2>
            <p><?php echo $is_admin ? 'Admin can view and edit all grades and sections' : 'Choose a grade level to view sections'; ?></p>
        </div>
        
        <!-- Folder Grid -->
        <div class="folder-grid">
            <div class="folder-card" onclick="location.href='select_section.php?grade=1'">
                <div class="folder-icon"><i class="fas fa-folder"></i></div>
                <div class="folder-info">
                    <div class="folder-name">1</div>
                    <div class="folder-label">Grade 1</div>
                </div>
            </div>
            <div class="folder-card" onclick="location.href='select_section.php?grade=2'">
                <div class="folder-icon"><i class="fas fa-folder"></i></div>
                <div class="folder-info">
                    <div class="folder-name">2</div>
                    <div class="folder-label">Grade 2</div>
                </div>
            </div>
            <div class="folder-card" onclick="location.href='select_section.php?grade=3'">
                <div class="folder-icon"><i class="fas fa-folder"></i></div>
                <div class="folder-info">
                    <div class="folder-name">3</div>
                    <div class="folder-label">Grade 3</div>
                </div>
            </div>
            <div class="folder-card" onclick="location.href='select_section.php?grade=4'">
                <div class="folder-icon"><i class="fas fa-folder"></i></div>
                <div class="folder-info">
                    <div class="folder-name">4</div>
                    <div class="folder-label">Grade 4</div>
                </div>
            </div>
            <div class="folder-card" onclick="location.href='select_section.php?grade=5'">
                <div class="folder-icon"><i class="fas fa-folder"></i></div>
                <div class="folder-info">
                    <div class="folder-name">5</div>
                    <div class="folder-label">Grade 5</div>
                </div>
            </div>
            <div class="folder-card" onclick="location.href='select_section.php?grade=6'">
                <div class="folder-icon"><i class="fas fa-folder"></i></div>
                <div class="folder-info">
                    <div class="folder-name">6</div>
                    <div class="folder-label">Grade 6</div>
                </div>
            </div>
        </div>
    </div>

    <script>
    function toggleSummary(e) {
        e.stopPropagation();
        document.getElementById('summaryWrap').classList.toggle('open');
    }
    // Close dropdown when clicking outside
    document.addEventListener('click', function() {
        document.getElementById('summaryWrap').classList.remove('open');
    });
    </script>
</body>
</html>