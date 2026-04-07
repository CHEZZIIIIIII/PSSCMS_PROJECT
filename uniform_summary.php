<?php
session_start();
require_once 'config.php';

// Allow both admin and teacher
if(!isset($_SESSION['logged_in']) || !in_array($_SESSION['usertype'], ['admin', 'teacher'])) {
    header('Location: index.php');
    exit();
}

$is_admin = ($_SESSION['usertype'] == 'admin');

$uniform_data = [];
$uniform_items = ['pe_tshirt', 'pe_pants', 'socks', 'shoes', 'school_uniform', 'uniform_bottom'];
$grand_totals = array_fill_keys($uniform_items, 0);

for ($grade = 1; $grade <= 6; $grade++) {
    $uniform_data[$grade] = ['sections'=>[], 'totals'=>array_fill_keys($uniform_items, 0)];
    
    $like_pattern = 'tblgrade' . $grade . '%uniform';
    $tables_stmt = mysqli_prepare($conn,
        "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
         WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME LIKE ?
         ORDER BY TABLE_NAME");
    mysqli_stmt_bind_param($tables_stmt, "s", $like_pattern);
    mysqli_stmt_execute($tables_stmt);
    $tables_result = mysqli_stmt_get_result($tables_stmt);
    
    while ($trow = mysqli_fetch_assoc($tables_result)) {
        $table_name = $trow['TABLE_NAME'];
        $section_name = '';
        if (preg_match('/tblgrade' . $grade . '([a-z_]+)uniform$/i', $table_name, $matches)) {
            $section_name = ucwords(str_replace('_', ' ', $matches[1]));
        } else {
            continue;
        }
        
        $section_data = ['name'=>$section_name, 'student_count'=>0, 'items'=>array_fill_keys($uniform_items, 0)];
        $student_table = 'tblgrade' . $grade . strtolower(str_replace(' ', '_', $section_name));
        $scr = mysqli_query($conn, "SELECT COUNT(*) as cnt FROM `$student_table`");
        if ($scr) { $cr = mysqli_fetch_assoc($scr); $section_data['student_count'] = (int)$cr['cnt']; }
        
        foreach ($uniform_items as $item) {
            $col_check = mysqli_query($conn, "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = '$table_name' AND COLUMN_NAME = '$item'");
            if ($col_check && mysqli_num_rows($col_check) > 0) {
                $ir = mysqli_query($conn, "SELECT COUNT(*) as cnt FROM `$table_name` WHERE `$item` IS NOT NULL AND `$item` != ''");
                if ($ir) {
                    $irow = mysqli_fetch_assoc($ir);
                    $count = (int)$irow['cnt'];
                    $section_data['items'][$item] = $count;
                    $uniform_data[$grade]['totals'][$item] += $count;
                    $grand_totals[$item] += $count;
                }
            }
        }
        $uniform_data[$grade]['sections'][] = $section_data;
    }
    mysqli_stmt_close($tables_stmt);
}

$grade_colors = [
    1=>['bg'=>'#e0f2fe','border'=>'#0284c7','text'=>'#0284c7'],
    2=>['bg'=>'#dcfce7','border'=>'#16a34a','text'=>'#16a34a'],
    3=>['bg'=>'#fef9c3','border'=>'#ca8a04','text'=>'#854d0e'],
    4=>['bg'=>'#ffe4e6','border'=>'#e11d48','text'=>'#be123c'],
    5=>['bg'=>'#ede9fe','border'=>'#7c3aed','text'=>'#6d28d9'],
    6=>['bg'=>'#ffedd5','border'=>'#ea580c','text'=>'#c2410c'],
];
$uniform_icons = ['pe_tshirt'=>'fa-tshirt','pe_pants'=>'fa-person-running','socks'=>'fa-socks','shoes'=>'fa-shoe-prints','school_uniform'=>'fa-user-graduate','uniform_bottom'=>'fa-vest'];
$uniform_labels = ['pe_tshirt'=>'PE T-Shirt','pe_pants'=>'PE Pants','socks'=>'Socks','shoes'=>'Shoes','school_uniform'=>'School Uniform','uniform_bottom'=>'Uniform Bottom'];

$chart_grade_labels = [];
$grade_bar_colors_hex = ['#0284c7','#16a34a','#ca8a04','#e11d48','#7c3aed','#ea580c'];
foreach ($uniform_data as $grade => $gd) {
    if (!empty($gd['sections'])) $chart_grade_labels[] = 'Grade ' . $grade;
}
$chart_item_labels = array_values($uniform_labels);
$chart_item_values = array_values($grand_totals);
$grade_total_per_item = [];
foreach ($uniform_data as $grade => $gd) {
    if (!empty($gd['sections'])) $grade_total_per_item[] = array_values($gd['totals']);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Uniform Summary - Palatiw Elementary</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', -apple-system, sans-serif; background: #f8fafb; min-height: 100vh; color: #1e293b; }

        .header { background: linear-gradient(135deg, #7c3aed 0%, #6d28d9 100%); color: white; padding: 24px 48px; box-shadow: 0 4px 20px rgba(124,58,237,0.15); position: sticky; top: 0; z-index: 100; }
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
        .back-btn { display: inline-flex; align-items: center; gap: 8px; background: white; color: #7c3aed; border: 2px solid #e2e8f0; padding: 10px 20px; border-radius: 12px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.2s; }
        .back-btn:hover { border-color: #7c3aed; box-shadow: 0 2px 8px rgba(124,58,237,0.15); }
        .nav-right { display: flex; gap: 12px; flex-wrap: wrap; }
        .btn-student { display: inline-flex; align-items: center; gap: 8px; background: #004643; color: white; border: none; padding: 11px 22px; border-radius: 12px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.3s; box-shadow: 0 2px 8px rgba(0,70,67,0.25); }
        .btn-student:hover { background: #003330; transform: translateY(-2px); }
        .btn-supplies { display: inline-flex; align-items: center; gap: 8px; background: #854d0e; color: white; border: none; padding: 11px 22px; border-radius: 12px; font-size: 14px; font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.3s; box-shadow: 0 2px 8px rgba(133,77,14,0.25); }
        .btn-supplies:hover { background: #713f0b; transform: translateY(-2px); }

        .page-header { margin-bottom: 32px; }
        .page-title { font-size: 32px; font-weight: 700; color: #1e293b; margin-bottom: 6px; display: flex; align-items: center; gap: 14px; flex-wrap: wrap; }
        .page-title i { color: #7c3aed; }
        .page-description { font-size: 15px; color: #64748b; }

        .summary-banner { background: linear-gradient(135deg, #7c3aed 0%, #6d28d9 100%); color: white; border-radius: 20px; padding: 32px; margin-bottom: 32px; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 24px; }
        .summary-stat { text-align: center; }
        .summary-stat-number { font-size: 48px; font-weight: 800; line-height: 1; margin-bottom: 8px; }
        .summary-stat-label { font-size: 13px; opacity: 0.9; text-transform: uppercase; letter-spacing: 0.5px; }

        .grade-section { background: white; border-radius: 20px; padding: 32px; box-shadow: 0 2px 12px rgba(0,0,0,0.04); border: 1px solid #f1f5f9; margin-bottom: 28px; }
        .grade-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 2px solid #f1f5f9; }
        .grade-title { display: flex; align-items: center; gap: 12px; font-size: 24px; font-weight: 700; }
        .grade-icon { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 18px; font-weight: 800; }

        .sections-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px; margin-bottom: 24px; }
        .section-card { background: #f8fafc; border-radius: 12px; padding: 20px; border: 1px solid #e2e8f0; }
        .section-card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
        .section-name { font-size: 16px; font-weight: 700; color: #1e293b; }
        .student-count { font-size: 12px; color: #64748b; background: white; padding: 4px 10px; border-radius: 20px; }
        .uniform-items { display: grid; grid-template-columns: repeat(2, 1fr); gap: 10px; }
        .uniform-item { display: flex; justify-content: space-between; align-items: center; font-size: 13px; padding: 6px 0; }
        .uniform-item-label { color: #64748b; display: flex; align-items: center; gap: 6px; }
        .uniform-item-label i { font-size: 11px; }
        .uniform-item-count { font-weight: 700; color: #1e293b; }

        .grade-totals { background: #ede9fe; border-radius: 12px; padding: 20px; border: 2px solid #c4b5fd; }
        .grade-totals-title { font-size: 14px; font-weight: 700; color: #7c3aed; margin-bottom: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .grade-totals-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); gap: 12px; }
        .grade-total-item { text-align: center; padding: 10px; background: white; border-radius: 8px; }
        .grade-total-item-count { font-size: 22px; font-weight: 800; color: #7c3aed; }
        .grade-total-item-label { font-size: 11px; color: #64748b; margin-top: 4px; }

        .grand-totals { background: linear-gradient(135deg, #1e293b 0%, #334155 100%); color: white; border-radius: 20px; padding: 32px; margin-top: 32px; }
        .grand-totals-title { font-size: 24px; font-weight: 800; margin-bottom: 24px; text-align: center; }
        .grand-totals-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 16px; }
        .grand-total-card { background: rgba(255,255,255,0.1); border-radius: 12px; padding: 20px; text-align: center; border: 1px solid rgba(255,255,255,0.2); }
        .grand-total-icon { font-size: 28px; margin-bottom: 12px; opacity: 0.9; }
        .grand-total-count { font-size: 32px; font-weight: 800; line-height: 1; margin-bottom: 8px; }
        .grand-total-label { font-size: 12px; opacity: 0.85; }

        .charts-section { margin-top: 40px; }
        .charts-section-title { font-size: 26px; font-weight: 800; color: #1e293b; margin-bottom: 8px; display: flex; align-items: center; gap: 12px; }
        .charts-section-title i { color: #7c3aed; }
        .charts-section-desc { font-size: 14px; color: #64748b; margin-bottom: 28px; }
        .charts-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; }
        @media (max-width: 900px) { .charts-grid { grid-template-columns: 1fr; } }
        .chart-card { background: white; border-radius: 20px; padding: 28px; box-shadow: 0 2px 12px rgba(0,0,0,0.05); border: 1px solid #f1f5f9; }
        .chart-card.full-width { grid-column: 1 / -1; }
        .chart-card-title { font-size: 16px; font-weight: 700; color: #1e293b; margin-bottom: 6px; display: flex; align-items: center; gap: 8px; }
        .chart-card-title i { color: #7c3aed; font-size: 14px; }
        .chart-card-desc { font-size: 12px; color: #94a3b8; margin-bottom: 20px; }
        .chart-wrapper { position: relative; width: 100%; }

        @media (max-width: 768px) {
            .header-content { flex-direction: column; gap: 20px; }
            .container { padding: 32px 24px; }
            .sections-grid { grid-template-columns: 1fr; }
            .uniform-items { grid-template-columns: 1fr; }
            .top-nav { flex-direction: column; align-items: flex-start; }
            .nav-right { width: 100%; }
        }
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
                    <div class="school-subtitle">Uniform Management System</div>
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
                <a href="student_summary.php" class="btn-student">
                    <i class="fas fa-users"></i> Student Summary
                </a>
                <a href="supplies_summary.php" class="btn-supplies">
                    <i class="fas fa-boxes"></i> Supplies Summary
                </a>
            </div>
        </div>

        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-tshirt"></i> Uniform Summary</h1>
            <p class="page-description">Overview of uniforms across all grades and sections</p>
        </div>

        <div class="summary-banner">
            <?php
            $total_uniforms = array_sum($grand_totals);
            $total_sections = 0;
            foreach ($uniform_data as $gd) $total_sections += count($gd['sections']);
            ?>
            <div class="summary-stat"><div class="summary-stat-number"><?php echo number_format($total_uniforms); ?></div><div class="summary-stat-label">Total Uniform Records</div></div>
            <div class="summary-stat"><div class="summary-stat-number">6</div><div class="summary-stat-label">Grade Levels</div></div>
            <div class="summary-stat"><div class="summary-stat-number"><?php echo $total_sections; ?></div><div class="summary-stat-label">Sections</div></div>
            <div class="summary-stat"><div class="summary-stat-number">6</div><div class="summary-stat-label">Uniform Items</div></div>
        </div>

        <?php foreach ($uniform_data as $grade => $grade_data): ?>
        <?php if (!empty($grade_data['sections'])): ?>
        <div class="grade-section">
            <div class="grade-header">
                <div class="grade-title">
                    <div class="grade-icon" style="background:<?php echo $grade_colors[$grade]['bg']; ?>; color:<?php echo $grade_colors[$grade]['text']; ?>;">G<?php echo $grade; ?></div>
                    <span style="color:<?php echo $grade_colors[$grade]['text']; ?>;">Grade <?php echo $grade; ?></span>
                </div>
            </div>
            <div class="sections-grid">
                <?php foreach ($grade_data['sections'] as $section): ?>
                <div class="section-card">
                    <div class="section-card-header">
                        <div class="section-name"><i class="fas fa-folder-open"></i> <?php echo htmlspecialchars($section['name']); ?></div>
                        <div class="student-count"><i class="fas fa-users"></i> <?php echo $section['student_count']; ?> students</div>
                    </div>
                    <div class="uniform-items">
                        <?php foreach ($uniform_items as $item): ?>
                        <div class="uniform-item">
                            <span class="uniform-item-label"><i class="fas <?php echo $uniform_icons[$item]; ?>"></i><?php echo $uniform_labels[$item]; ?></span>
                            <span class="uniform-item-count"><?php echo $section['items'][$item]; ?></span>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
            <div class="grade-totals">
                <div class="grade-totals-title"><i class="fas fa-calculator"></i> Grade <?php echo $grade; ?> Totals</div>
                <div class="grade-totals-grid">
                    <?php foreach ($uniform_items as $item): ?>
                    <div class="grade-total-item">
                        <div class="grade-total-item-count"><?php echo number_format($grade_data['totals'][$item]); ?></div>
                        <div class="grade-total-item-label"><?php echo $uniform_labels[$item]; ?></div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>
        <?php endif; ?>
        <?php endforeach; ?>

        <div class="grand-totals">
            <div class="grand-totals-title"><i class="fas fa-chart-bar"></i> Grand Totals (All Grades)</div>
            <div class="grand-totals-grid">
                <?php foreach ($uniform_items as $item): ?>
                <div class="grand-total-card">
                    <div class="grand-total-icon"><i class="fas <?php echo $uniform_icons[$item]; ?>"></i></div>
                    <div class="grand-total-count"><?php echo number_format($grand_totals[$item]); ?></div>
                    <div class="grand-total-label"><?php echo $uniform_labels[$item]; ?></div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>

        <div class="charts-section">
            <h2 class="charts-section-title"><i class="fas fa-chart-line"></i> Visual Analytics</h2>
            <p class="charts-section-desc">Charts generated from the uniform data above</p>
            <div class="charts-grid">
                <div class="chart-card">
                    <div class="chart-card-title"><i class="fas fa-bars"></i> Uniform Items — Grand Total</div>
                    <div class="chart-card-desc">Total count of each uniform item across all grades</div>
                    <div class="chart-wrapper" style="height:300px;"><canvas id="chartItemTotals"></canvas></div>
                </div>
                <div class="chart-card">
                    <div class="chart-card-title"><i class="fas fa-circle-notch"></i> Distribution by Grade</div>
                    <div class="chart-card-desc">Share of total uniform records per grade level</div>
                    <div class="chart-wrapper" style="height:300px;"><canvas id="chartGradeDist"></canvas></div>
                </div>
                <div class="chart-card full-width">
                    <div class="chart-card-title"><i class="fas fa-chart-bar"></i> Uniform Items by Grade — Grouped Comparison</div>
                    <div class="chart-card-desc">Side-by-side count of each uniform item broken down by grade</div>
                    <div class="chart-wrapper" style="height:360px;"><canvas id="chartGrouped"></canvas></div>
                </div>
            </div>
        </div>
    </div>

    <script>
    const uniformItems = <?php echo json_encode($chart_item_labels); ?>;
    const grandTotals  = <?php echo json_encode($chart_item_values); ?>;
    const gradeLabels  = <?php echo json_encode($chart_grade_labels); ?>;
    const gradeTotalPerItem = <?php echo json_encode($grade_total_per_item); ?>;
    const gradeBarColors    = <?php echo json_encode($grade_bar_colors_hex); ?>;
    const gradeTotals = gradeTotalPerItem.map(items => items.reduce((a,b)=>a+b,0));
    const itemColors = ['#7c3aed','#6d28d9','#5b21b6','#4c1d95','#3730a3','#312e81'];
    Chart.defaults.font.family = "'Inter', sans-serif";
    new Chart(document.getElementById('chartItemTotals'), { type:'bar', data:{ labels:uniformItems, datasets:[{ label:'Total Count', data:grandTotals, backgroundColor:itemColors, borderRadius:6, borderSkipped:false }] }, options:{ indexAxis:'y', responsive:true, maintainAspectRatio:false, plugins:{ legend:{display:false}, tooltip:{callbacks:{label:ctx=>' '+ctx.parsed.x+' units'}} }, scales:{ x:{grid:{color:'#f1f5f9'},ticks:{color:'#64748b',font:{size:11}}}, y:{grid:{display:false},ticks:{color:'#334155',font:{size:12,weight:'600'}}} } } });
    new Chart(document.getElementById('chartGradeDist'), { type:'doughnut', data:{ labels:gradeLabels, datasets:[{ data:gradeTotals, backgroundColor:gradeBarColors, borderWidth:3, borderColor:'#fff', hoverOffset:8 }] }, options:{ responsive:true, maintainAspectRatio:false, cutout:'60%', plugins:{ legend:{position:'bottom',labels:{padding:16,color:'#334155',font:{size:12,weight:'600'}}}, tooltip:{callbacks:{label:ctx=>' '+ctx.label+': '+ctx.parsed+' records'}} } } });
    new Chart(document.getElementById('chartGrouped'), { type:'bar', data:{ labels:uniformItems, datasets:gradeLabels.map((label,gi)=>({ label, data:gradeTotalPerItem[gi], backgroundColor:gradeBarColors[gi]+'cc', borderColor:gradeBarColors[gi], borderWidth:1.5, borderRadius:4 })) }, options:{ responsive:true, maintainAspectRatio:false, plugins:{ legend:{position:'top',labels:{padding:16,color:'#334155',font:{size:12,weight:'600'}}} }, scales:{ x:{grid:{display:false},ticks:{color:'#334155',font:{size:11,weight:'600'}}}, y:{grid:{color:'#f1f5f9'},ticks:{color:'#64748b',font:{size:11}}} } } });
    </script>
</body>
</html>
<?php mysqli_close($conn); ?>