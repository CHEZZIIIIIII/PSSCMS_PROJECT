<?php
session_start();
require_once 'config.php';

// Allow both admin and teacher
if(!isset($_SESSION['logged_in']) || !in_array($_SESSION['usertype'], ['admin', 'teacher'])) {
    header('Location: index.php');
    exit();
}

$is_admin = ($_SESSION['usertype'] == 'admin');

// ── Count students per grade (with section breakdown) ──
$grade_totals  = [];
$grade_males   = [];
$grade_females = [];
$grade_sections = [];
$overall_total = 0;
$total_males   = 0;
$total_females = 0;

$grade_hex = ['#0284c7','#16a34a','#ca8a04','#e11d48','#7c3aed','#ea580c'];

for ($g = 1; $g <= 6; $g++) {
    $grade_totals[$g]  = 0;
    $grade_males[$g]   = 0;
    $grade_females[$g] = 0;
    $grade_sections[$g] = [];

    $like_pattern = 'tblgrade' . $g . '%';
    $tables_stmt  = mysqli_prepare($conn,
        "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
         WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME LIKE ?
         ORDER BY TABLE_NAME");
    mysqli_stmt_bind_param($tables_stmt, "s", $like_pattern);
    mysqli_stmt_execute($tables_stmt);
    $tables_result = mysqli_stmt_get_result($tables_stmt);

    while ($trow = mysqli_fetch_assoc($tables_result)) {
        $tbl = $trow['TABLE_NAME'];
        if (strpos($tbl, 'supplies') !== false || strpos($tbl, 'uniform') !== false) continue;

        $section_name = '';
        if (preg_match('/tblgrade' . $g . '([a-z_]+)$/i', $tbl, $matches)) {
            $section_name = ucwords(str_replace('_', ' ', $matches[1]));
        } else {
            continue;
        }

        $cnt_row = mysqli_fetch_assoc(mysqli_query($conn, "SELECT COUNT(*) AS cnt FROM `$tbl`"));
        $section_total = (int)$cnt_row['cnt'];
        $section_males = 0;
        $section_females = 0;

        $col_check = mysqli_query($conn,
            "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
             WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '$tbl' AND COLUMN_NAME = 'gender'");
        if ($col_check && mysqli_num_rows($col_check) > 0) {
            $g_res = mysqli_query($conn, "SELECT gender, COUNT(*) AS gcnt FROM `$tbl` GROUP BY gender");
            while ($gr = mysqli_fetch_assoc($g_res)) {
                if (strtoupper($gr['gender']) === 'MALE')   { $section_males   = (int)$gr['gcnt']; $grade_males[$g]   += $section_males; }
                if (strtoupper($gr['gender']) === 'FEMALE') { $section_females = (int)$gr['gcnt']; $grade_females[$g] += $section_females; }
            }
        }

        $grade_sections[$g][] = ['name'=>$section_name,'total'=>$section_total,'males'=>$section_males,'females'=>$section_females];
        $grade_totals[$g] += $section_total;
    }
    mysqli_stmt_close($tables_stmt);

    $overall_total += $grade_totals[$g];
    $total_males   += $grade_males[$g];
    $total_females += $grade_females[$g];
}

$grade_themes = [
    1 => ['bg'=>'#e0f2fe','border'=>'#0284c7','text'=>'#0284c7'],
    2 => ['bg'=>'#dcfce7','border'=>'#16a34a','text'=>'#16a34a'],
    3 => ['bg'=>'#fef9c3','border'=>'#ca8a04','text'=>'#854d0e'],
    4 => ['bg'=>'#ffe4e6','border'=>'#e11d48','text'=>'#be123c'],
    5 => ['bg'=>'#ede9fe','border'=>'#7c3aed','text'=>'#6d28d9'],
    6 => ['bg'=>'#ffedd5','border'=>'#ea580c','text'=>'#c2410c'],
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List Summary - Palatiw Elementary</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', -apple-system, sans-serif; background: #f8fafb; min-height: 100vh; color: #1e293b; }

        .header { background: linear-gradient(135deg, #004643 0%, #006b66 100%); color: white; padding: 24px 48px; box-shadow: 0 4px 20px rgba(0,70,67,0.15); position: sticky; top: 0; z-index: 100; }
        .header-content { max-width: 1400px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .header-left { display: flex; align-items: center; gap: 20px; }
        .school-logo-header { width: 70px; height: 70px; background: white; border-radius: 16px; padding: 10px; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 16px rgba(0,0,0,0.1); }
        .school-logo-header img { width: 100%; height: 100%; object-fit: contain; }
        .school-info { display: flex; flex-direction: column; gap: 4px; }
        .school-name { font-size: 28px; font-weight: 700; letter-spacing: -0.5px; }
        .school-subtitle { font-size: 14px; opacity: 0.9; }
        .header-right { display: flex; align-items: center; gap: 24px; }
        .user-info { display: flex; flex-direction: column; align-items: flex-end; gap: 2px; }
        .user-role { font-size: 12px; opacity: 0.8; font-weight: 500; text-transform: uppercase; letter-spacing: 0.5px; }
        .user-name { font-size: 16px; font-weight: 600; }
        .btn-logout { background: rgba(255,255,255,0.15); backdrop-filter: blur(10px); color: white; border: 2px solid rgba(255,255,255,0.3); padding: 10px 24px; border-radius: 12px; cursor: pointer; font-size: 14px; font-weight: 600; transition: all 0.3s ease; display: flex; align-items: center; gap: 8px; }
        .btn-logout:hover { background: rgba(255,255,255,0.25); border-color: rgba(255,255,255,0.5); transform: translateY(-2px); }

        .container { max-width: 1400px; margin: 0 auto; padding: 40px 48px; }

        .top-nav { display: flex; justify-content: space-between; align-items: center; margin-bottom: 28px; flex-wrap: wrap; gap: 12px; }
        .back-btn { display: inline-flex; align-items: center; gap: 8px; background: white; color: #004643; border: 2px solid #e2e8f0; padding: 10px 20px; border-radius: 12px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.2s; }
        .back-btn:hover { border-color: #004643; box-shadow: 0 2px 8px rgba(0,70,67,0.15); }

        .nav-right { display: flex; gap: 12px; flex-wrap: wrap; }

        .btn-supplies { display: inline-flex; align-items: center; gap: 8px; background: #854d0e; color: white; border: none; padding: 11px 22px; border-radius: 12px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.3s; box-shadow: 0 2px 8px rgba(133,77,14,0.25); }
        .btn-supplies:hover { background: #713f0b; transform: translateY(-2px); box-shadow: 0 4px 14px rgba(133,77,14,0.35); }
        .btn-uniform { display: inline-flex; align-items: center; gap: 8px; background: #7c3aed; color: white; border: none; padding: 11px 22px; border-radius: 12px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.3s; box-shadow: 0 2px 8px rgba(124,58,237,0.25); }
        .btn-uniform:hover { background: #6d28d9; transform: translateY(-2px); box-shadow: 0 4px 14px rgba(124,58,237,0.35); }

        .page-header { margin-bottom: 32px; }
        .page-title { font-size: 32px; font-weight: 700; color: #1e293b; margin-bottom: 6px; display: flex; align-items: center; gap: 14px; flex-wrap: wrap; }
        .page-title i { color: #004643; }
        .page-description { font-size: 15px; color: #64748b; }
        .live-badge { display: inline-flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 600; color: #16a34a; background: #f0fdf4; border: 1px solid #bbf7d0; padding: 5px 12px; border-radius: 20px; }
        .live-badge i { font-size: 8px; animation: blink 1.5s ease-in-out infinite; }
        @keyframes blink { 0%,100%{opacity:1} 50%{opacity:0.3} }

        .summary-banner { background: linear-gradient(135deg, #004643 0%, #006b66 100%); color: white; border-radius: 20px; padding: 28px 36px; display: flex; align-items: center; gap: 28px; margin-bottom: 32px; flex-wrap: wrap; }
        .summary-banner-icon { width: 68px; height: 68px; background: rgba(255,255,255,0.15); border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 30px; flex-shrink: 0; }
        .summary-banner-main { flex: 1; min-width: 140px; }
        .summary-banner-number { font-size: 56px; font-weight: 800; line-height: 1; letter-spacing: -2px; }
        .summary-banner-label  { font-size: 14px; opacity: 0.85; margin-top: 4px; }
        .summary-banner-gender { display: flex; gap: 14px; flex-wrap: wrap; }
        .gender-pill { display: flex; align-items: center; gap: 12px; padding: 12px 20px; border-radius: 14px; min-width: 110px; }
        .gender-pill i { font-size: 22px; }
        .gender-pill-count { font-size: 22px; font-weight: 800; line-height: 1; }
        .gender-pill-label { font-size: 12px; opacity: 0.85; margin-top: 2px; }
        .gender-male   { background: rgba(59,130,246,0.2);  border: 1px solid rgba(59,130,246,0.35); }
        .gender-female { background: rgba(236,72,153,0.2);  border: 1px solid rgba(236,72,153,0.35); }

        .grade-cards-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 32px; }
        .grade-card { background: white; border-radius: 16px; padding: 24px; border: 1px solid #f1f5f9; box-shadow: 0 2px 10px rgba(0,0,0,0.04); transition: transform 0.2s, box-shadow 0.2s; }
        .grade-card:hover { transform: translateY(-4px); box-shadow: 0 10px 28px rgba(0,0,0,0.09); }
        .grade-card-header { display: flex; align-items: center; gap: 16px; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 2px solid #f1f5f9; }
        .grade-card-icon { width: 56px; height: 56px; border-radius: 14px; flex-shrink: 0; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: 800; }
        .grade-card-info { flex: 1; }
        .grade-card-label { font-size: 12px; color: #94a3b8; font-weight: 500; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 4px; }
        .grade-card-total { font-size: 36px; font-weight: 800; color: #1e293b; line-height: 1; letter-spacing: -1px; }
        .grade-card-gender { display: flex; gap: 8px; margin-top: 6px; }
        .g-male, .g-female { font-size: 11px; font-weight: 600; padding: 3px 9px; border-radius: 20px; }
        .g-male   { background: #eff6ff; color: #1e40af; }
        .g-female { background: #fdf2f8; color: #9d174d; }

        .sections-list { display: flex; flex-direction: column; gap: 10px; }
        .section-item { display: flex; justify-content: space-between; align-items: center; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; transition: all 0.2s; }
        .section-item:hover { background: #f1f5f9; border-color: #cbd5e1; }
        .section-name { font-size: 13px; font-weight: 600; color: #334155; display: flex; align-items: center; gap: 6px; }
        .section-name i { font-size: 11px; color: #64748b; }
        .section-stats { display: flex; gap: 8px; align-items: center; }
        .section-count { font-size: 15px; font-weight: 700; color: #1e293b; }
        .section-gender-mini { font-size: 10px; color: #64748b; }

        .section { background: white; border-radius: 20px; padding: 40px; box-shadow: 0 2px 12px rgba(0,0,0,0.04); border: 1px solid #f1f5f9; margin-bottom: 32px; }
        .section-title { font-size: 20px; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 10px; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 2px solid #f1f5f9; }
        .section-title i { color: #004643; }

        .charts-stack { display: flex; flex-direction: column; gap: 28px; }
        .chart-box { background: #f8fafc; border-radius: 14px; padding: 24px 28px; border: 1px solid #f1f5f9; }
        .chart-box-title { font-size: 14px; font-weight: 700; color: #334155; margin-bottom: 18px; display: flex; align-items: center; gap: 8px; }
        .chart-box-title i { color: #004643; }
        .chart-area-grade   { position: relative; height: 280px; }
        .chart-area-gender  { position: relative; height: 260px; max-width: 480px; margin: 0 auto; }
        .chart-area-section { position: relative; height: 320px; }

        .table-container { overflow-x: auto; border-radius: 12px; border: 1px solid #f1f5f9; }
        table { width: 100%; border-collapse: collapse; }
        table th { background: #f8fafc; color: #1e293b; padding: 15px 24px; text-align: left; font-weight: 700; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 2px solid #e2e8f0; }
        table td { padding: 18px 24px; border-bottom: 1px solid #f1f5f9; font-size: 15px; color: #334155; }
        table tbody tr:hover { background: #f8fafc; }
        table tbody tr:last-child td { border-bottom: none; }

        .grade-pill { display: inline-flex; align-items: center; gap: 8px; padding: 7px 18px; border-radius: 20px; font-size: 14px; font-weight: 700; }
        .count-big   { font-size: 20px; font-weight: 800; color: #1e293b; }
        .count-badge { padding: 5px 14px; border-radius: 20px; font-size: 13px; font-weight: 600; display: inline-block; }
        .count-male   { background: #eff6ff; color: #1e40af; }
        .count-female { background: #fdf2f8; color: #9d174d; }
        .grand-total-row td { background: #f1f5f9; border-top: 2px solid #e2e8f0; font-weight: 700; padding: 18px 24px; }

        @media (max-width: 1100px) { .grade-cards-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 768px) {
            .header-content { flex-direction: column; gap: 20px; text-align: center; }
            .header-left { flex-direction: column; gap: 16px; }
            .school-info { align-items: center; }
            .header-right { flex-direction: column; gap: 16px; width: 100%; }
            .user-info { align-items: center; }
            .btn-logout { width: 100%; justify-content: center; }
            .container { padding: 32px 24px; }
            .header { padding: 20px 24px; }
            .section { padding: 28px 20px; }
            .summary-banner { padding: 22px 20px; }
            .top-nav { flex-direction: column; align-items: flex-start; }
            .nav-right { width: 100%; }
        }
        @media (max-width: 640px) { .grade-cards-grid { grid-template-columns: 1fr; } .container { padding: 20px 14px; } }
    </style>
</head>
<body>

    <div class="header">
        <div class="header-content">
            <div class="header-left">
                <div class="school-logo-header">
                    <img src="logo.png" alt="Palatiw Elementary School Logo" onerror="this.style.display='none'" />
                </div>
                <div class="school-info">
                    <div class="school-name">Palatiw Elementary School</div>
                    <div class="school-subtitle">Student Management System</div>
                </div>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <div class="user-role"><?php echo $is_admin ? 'Administrator' : 'Teacher'; ?></div>
                    <div class="user-name"><?php echo htmlspecialchars($_SESSION['username']); ?></div>
                </div>
                <button class="btn-logout" onclick="location.href='logout.php'">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="top-nav">
            <a href="<?php echo $is_admin ? 'admin_dashboard.php' : 'select_grade.php'; ?>" class="back-btn">
                <i class="fas fa-arrow-left"></i> <?php echo $is_admin ? 'Back to Dashboard' : 'Back to Grades'; ?>
            </a>
            <div class="nav-right">
                <a href="supplies_summary.php" class="btn-supplies">
                    <i class="fas fa-boxes"></i> Supplies Summary
                </a>
                <a href="uniform_summary.php" class="btn-uniform">
                    <i class="fas fa-tshirt"></i> Uniform Summary
                </a>
            </div>
        </div>

        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-users"></i>
                Student List Summary
                <span class="live-badge"><i class="fas fa-circle"></i> Live Data</span>
            </h1>
            <p class="page-description">Total number of enrolled students per grade level and section</p>
        </div>

        <!-- Grand Total Banner -->
        <div class="summary-banner">
            <div class="summary-banner-icon"><i class="fas fa-users"></i></div>
            <div class="summary-banner-main">
                <div class="summary-banner-number"><?php echo number_format($overall_total); ?></div>
                <div class="summary-banner-label">Total Students Enrolled — Grade 1 to Grade 6</div>
            </div>
            <div class="summary-banner-gender">
                <div class="gender-pill gender-male">
                    <i class="fas fa-mars"></i>
                    <div>
                        <div class="gender-pill-count"><?php echo number_format($total_males); ?></div>
                        <div class="gender-pill-label">Male</div>
                    </div>
                </div>
                <div class="gender-pill gender-female">
                    <i class="fas fa-venus"></i>
                    <div>
                        <div class="gender-pill-count"><?php echo number_format($total_females); ?></div>
                        <div class="gender-pill-label">Female</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Grade Cards -->
        <div class="grade-cards-grid">
            <?php foreach ($grade_themes as $g => $th): ?>
            <div class="grade-card" style="border-left: 5px solid <?php echo $th['border']; ?>;">
                <div class="grade-card-header">
                    <div class="grade-card-icon" style="background:<?php echo $th['bg']; ?>; color:<?php echo $th['text']; ?>;">
                        G<?php echo $g; ?>
                    </div>
                    <div class="grade-card-info">
                        <div class="grade-card-label">Grade <?php echo $g; ?></div>
                        <div class="grade-card-total"><?php echo number_format($grade_totals[$g]); ?></div>
                        <div class="grade-card-gender">
                            <span class="g-male"><i class="fas fa-mars"></i> <?php echo number_format($grade_males[$g]); ?></span>
                            <span class="g-female"><i class="fas fa-venus"></i> <?php echo number_format($grade_females[$g]); ?></span>
                        </div>
                    </div>
                </div>
                <div class="sections-list">
                    <?php if (!empty($grade_sections[$g])): ?>
                        <?php foreach ($grade_sections[$g] as $sec): ?>
                        <div class="section-item">
                            <div class="section-name">
                                <i class="fas fa-folder-open"></i>
                                <?php echo htmlspecialchars($sec['name']); ?>
                            </div>
                            <div class="section-stats">
                                <span class="section-count"><?php echo number_format($sec['total']); ?></span>
                                <span class="section-gender-mini">(&#9794;<?php echo $sec['males']; ?> &#9792;<?php echo $sec['females']; ?>)</span>
                            </div>
                        </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <div class="section-item" style="justify-content:center;color:#94a3b8;"><i>No sections found</i></div>
                    <?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>

        <!-- Charts -->
        <div class="section">
            <h2 class="section-title"><i class="fas fa-chart-bar"></i> Enrollment Charts</h2>
            <div class="charts-stack">
                <div class="chart-box">
                    <div class="chart-box-title"><i class="fas fa-chart-bar"></i> Students per Grade</div>
                    <div class="chart-area-grade"><canvas id="gradeBarChart"></canvas></div>
                </div>
                <div class="chart-box">
                    <div class="chart-box-title"><i class="fas fa-venus-mars"></i> Gender Distribution</div>
                    <div class="chart-area-gender"><canvas id="genderChart"></canvas></div>
                </div>
                <div class="chart-box">
                    <div class="chart-box-title"><i class="fas fa-layer-group"></i> Male vs Female per Grade</div>
                    <div class="chart-area-section"><canvas id="genderPerGradeChart"></canvas></div>
                </div>
            </div>
        </div>

        <!-- Summary Table -->
        <div class="section">
            <h2 class="section-title"><i class="fas fa-table"></i> Student Count per Grade</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Grade Level</th>
                            <th><i class="fas fa-mars" style="color:#3b82f6;"></i> Male</th>
                            <th><i class="fas fa-venus" style="color:#ec4899;"></i> Female</th>
                            <th>Total Students</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($grade_themes as $g => $th): ?>
                        <tr>
                            <td><span class="grade-pill" style="background:<?php echo $th['bg']; ?>; color:<?php echo $th['text']; ?>;"><i class="fas fa-graduation-cap"></i> Grade <?php echo $g; ?></span></td>
                            <td><span class="count-badge count-male"><?php echo number_format($grade_males[$g]); ?></span></td>
                            <td><span class="count-badge count-female"><?php echo number_format($grade_females[$g]); ?></span></td>
                            <td><span class="count-big"><?php echo number_format($grade_totals[$g]); ?></span></td>
                        </tr>
                        <?php endforeach; ?>
                        <tr class="grand-total-row">
                            <td><strong>GRAND TOTAL</strong></td>
                            <td><strong><?php echo number_format($total_males); ?></strong></td>
                            <td><strong><?php echo number_format($total_females); ?></strong></td>
                            <td><strong style="font-size:20px;"><?php echo number_format($overall_total); ?></strong></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <script>
    Chart.defaults.font.family = "'Inter', -apple-system, sans-serif";
    const DATA = {
        gradeLabels: ['Grade 1','Grade 2','Grade 3','Grade 4','Grade 5','Grade 6'],
        gradeTotals: <?php echo json_encode(array_values($grade_totals)); ?>,
        gradeMales:  <?php echo json_encode(array_values($grade_males)); ?>,
        gradeFemales:<?php echo json_encode(array_values($grade_females)); ?>,
        gradeColors: <?php echo json_encode($grade_hex); ?>,
        totalMales:  <?php echo (int)$total_males; ?>,
        totalFemales:<?php echo (int)$total_females; ?>
    };
    function hexAlpha(hex, a) {
        const r = parseInt(hex.slice(1,3),16), g = parseInt(hex.slice(3,5),16), b = parseInt(hex.slice(5,7),16);
        return `rgba(${r},${g},${b},${a})`;
    }
    new Chart(document.getElementById('gradeBarChart'), {
        type: 'bar',
        data: { labels: DATA.gradeLabels, datasets: [{ label: 'Total Students', data: DATA.gradeTotals, backgroundColor: DATA.gradeColors.map(c=>hexAlpha(c,0.2)), borderColor: DATA.gradeColors, borderWidth: 2.5, borderRadius: 10, borderSkipped: false }] },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false }, tooltip: { callbacks: { label: ctx => '  '+ctx.parsed.y.toLocaleString()+' students' } } }, scales: { y: { beginAtZero: true, grid: { color: '#f1f5f9' }, ticks: { color: '#64748b', font: { size: 13 } } }, x: { grid: { display: false }, ticks: { color: '#334155', font: { size: 13, weight: '600' } } } } }
    });
    new Chart(document.getElementById('genderChart'), {
        type: 'doughnut',
        data: { labels: ['Male', 'Female'], datasets: [{ data: [DATA.totalMales, DATA.totalFemales], backgroundColor: ['rgba(59,130,246,0.82)', 'rgba(236,72,153,0.82)'], borderColor: ['#3b82f6', '#ec4899'], borderWidth: 2, hoverOffset: 12 }] },
        options: { responsive: true, maintainAspectRatio: false, cutout: '66%', plugins: { legend: { position: 'bottom', labels: { padding: 20, font: { size: 14, weight: '600' }, usePointStyle: true } }, tooltip: { callbacks: { label: ctx => { const tot = DATA.totalMales + DATA.totalFemales; const pct = tot > 0 ? Math.round(ctx.parsed / tot * 100) : 0; return '  '+ctx.parsed.toLocaleString()+'  ('+pct+'%)'; } } } } }
    });
    new Chart(document.getElementById('genderPerGradeChart'), {
        type: 'bar',
        data: { labels: DATA.gradeLabels, datasets: [ { label: 'Male', data: DATA.gradeMales, backgroundColor: 'rgba(59,130,246,0.2)', borderColor: '#3b82f6', borderWidth: 2, borderRadius: 8, borderSkipped: false }, { label: 'Female', data: DATA.gradeFemales, backgroundColor: 'rgba(236,72,153,0.2)', borderColor: '#ec4899', borderWidth: 2, borderRadius: 8, borderSkipped: false } ] },
        options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom', labels: { padding: 16, font: { size: 13, weight: '600' }, usePointStyle: true } }, tooltip: { callbacks: { label: ctx => '  '+ctx.dataset.label+': '+ctx.parsed.y.toLocaleString() } } }, scales: { y: { beginAtZero: true, grid: { color: '#f1f5f9' }, ticks: { color: '#64748b', font: { size: 13 } } }, x: { grid: { display: false }, ticks: { color: '#334155', font: { size: 13, weight: '600' } } } } }
    });
    </script>
</body>
</html>