<?php
session_start();
require_once 'config.php';

if(!isset($_SESSION['logged_in']) || $_SESSION['usertype'] != 'admin') {
    header('Location: index.php');
    exit();
}

// Fetch all available sections per grade
$available_sections = [];
for ($grade = 1; $grade <= 6; $grade++) {
    $available_sections[$grade] = [];
    $like_pattern = 'tblgrade' . $grade . '%';
    $tables_stmt = mysqli_prepare($conn,
        "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
         WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME LIKE ?
         AND TABLE_NAME NOT LIKE '%supplies'
         AND TABLE_NAME NOT LIKE '%uniform'
         ORDER BY TABLE_NAME");
    mysqli_stmt_bind_param($tables_stmt, "s", $like_pattern);
    mysqli_stmt_execute($tables_stmt);
    $tables_result = mysqli_stmt_get_result($tables_stmt);
    while ($trow = mysqli_fetch_assoc($tables_result)) {
        $table_name = $trow['TABLE_NAME'];
        if (preg_match('/tblgrade' . $grade . '([a-z_]+)$/i', $table_name, $matches)) {
            $section_name = str_replace('_', ' ', $matches[1]);
            $section_name = ucwords($section_name);
            $available_sections[$grade][] = ['name' => $section_name, 'table' => $table_name];
        }
    }
    mysqli_stmt_close($tables_stmt);
}

// Helper: count sizes for a uniform column
function countSizes($conn, $table, $column) {
    $sizes = ['XS'=>0,'S'=>0,'M'=>0,'L'=>0,'XL'=>0,'XXL'=>0,'Other'=>0];
    $result = mysqli_query($conn, "SELECT `$column` FROM `$table` WHERE `$column` IS NOT NULL AND `$column` != ''");
    if (!$result) return $sizes;
    while ($row = mysqli_fetch_row($result)) {
        $val = strtoupper(trim($row[0]));
        if (isset($sizes[$val])) $sizes[$val]++;
        elseif ($val !== '') $sizes['Other']++;
    }
    return $sizes;
}

// Helper: merge size arrays
function mergeSizes($a, $b) {
    $result = $a;
    foreach ($b as $k => $v) {
        $result[$k] = ($result[$k] ?? 0) + $v;
    }
    return $result;
}

$report_data = [];
$show_report = false;
$report_type_selected = 'students';

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['generate_report'])) {
    $report_type_selected = $_POST['report_type'] ?? 'students';

    // Process any grade that has at least one section checked,
    // regardless of whether the grade-level checkbox was ticked.
    foreach ([1,2,3,4,5,6] as $grade) {
        $selected_sections = $_POST['sections_' . $grade] ?? [];
        if (!empty($selected_sections)) {
            $report_data[$grade] = [];
            foreach ($selected_sections as $section_table) {
                $section_name = '';
                if (preg_match('/tblgrade' . $grade . '([a-z_]+)$/i', $section_table, $matches)) {
                    $section_name = ucwords(str_replace('_', ' ', $matches[1]));
                }
                $section_data = ['name'=>$section_name,'students'=>[],'supplies'=>[],'uniforms'=>[],'uniform_sizes'=>[]];

                // ── Students ──
                if ($report_type_selected == 'students' || $report_type_selected == 'all') {
                    $q = "SELECT lrn_number,
                                 CONCAT(last_name, ', ', first_name,
                                        IF(middle_name IS NOT NULL AND middle_name != '',
                                           CONCAT(' ', middle_name), '')) AS full_name,
                                 gender, age, contact_number, parent_name, parent_contact
                          FROM `$section_table`
                          ORDER BY last_name, first_name";
                    $r = mysqli_query($conn, $q);
                    if ($r) while ($row = mysqli_fetch_assoc($r)) $section_data['students'][] = $row;
                }

                // ── Supplies ──
                if ($report_type_selected == 'supplies' || $report_type_selected == 'all') {
                    $st = $section_table . 'supplies';
                    $chk = mysqli_query($conn, "SHOW TABLES LIKE '$st'");
                    if (mysqli_num_rows($chk) > 0) {
                        $r = mysqli_query($conn, "SELECT lrn, student_name, notebooks, padpaper, bag, ballpen, pencil, sharpener, crayons, eraser, ruler, scissors, glue FROM `$st` ORDER BY student_name");
                        if ($r) while ($row = mysqli_fetch_assoc($r)) $section_data['supplies'][] = $row;
                    }
                }

                // ── Uniforms + sizes ──
                if ($report_type_selected == 'uniforms' || $report_type_selected == 'all') {
                    $ut = $section_table . 'uniform';
                    $chk = mysqli_query($conn, "SHOW TABLES LIKE '$ut'");
                    if (mysqli_num_rows($chk) > 0) {
                        $r = mysqli_query($conn, "SELECT lrn, student_name, gender, pe_tshirt, pe_pants, socks, shoes, school_uniform, uniform_bottom FROM `$ut` ORDER BY student_name");
                        if ($r) while ($row = mysqli_fetch_assoc($r)) $section_data['uniforms'][] = $row;
                        foreach (['pe_tshirt','pe_pants','socks','shoes','school_uniform','uniform_bottom'] as $col) {
                            $section_data['uniform_sizes'][$col] = countSizes($conn, $ut, $col);
                        }
                    }
                }
                $report_data[$grade][] = $section_data;
            }
        }
    }
    $show_report = !empty($report_data);
}

$grade_colors = [1=>'#0284c7',2=>'#16a34a',3=>'#ca8a04',4=>'#e11d48',5=>'#7c3aed',6=>'#ea580c'];
$uniform_col_labels = [
    'pe_tshirt'=>'PE T-Shirt','pe_pants'=>'PE Pants','socks'=>'Socks',
    'shoes'=>'Shoes','school_uniform'=>'School Uniform (Top)','uniform_bottom'=>'Uniform Bottom',
];
$supplies_labels = [
    'notebooks'=>'Notebooks','padpaper'=>'Pad Paper','bag'=>'Bag',
    'ballpen'=>'Ballpen','pencil'=>'Pencil','sharpener'=>'Sharpener',
    'crayons'=>'Crayons','eraser'=>'Eraser','ruler'=>'Ruler',
    'scissors'=>'Scissors','glue'=>'Glue',
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Consolidated Report – Palatiw Elementary</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter',system-ui,sans-serif;background:#f0f4f8;min-height:100vh;color:#1e293b}

/* ── HEADER ── */
.header{background:linear-gradient(135deg,#004643 0%,#006b66 100%);color:white;padding:24px 48px;box-shadow:0 4px 20px rgba(0,70,67,.15);position:sticky;top:0;z-index:100}
.header-content{max-width:1400px;margin:0 auto;display:flex;justify-content:space-between;align-items:center}
.header-left{display:flex;align-items:center;gap:20px}
.school-logo-header{width:70px;height:70px;background:white;border-radius:16px;padding:10px;display:flex;align-items:center;justify-content:center;box-shadow:0 4px 16px rgba(0,0,0,.1)}
.school-logo-header img{width:100%;height:100%;object-fit:contain}
.school-info{display:flex;flex-direction:column;gap:4px}
.school-name{font-size:28px;font-weight:700;letter-spacing:-.5px}
.school-subtitle{font-size:14px;opacity:.9}
.header-right{display:flex;align-items:center;gap:24px}
.user-info{display:flex;flex-direction:column;align-items:flex-end;gap:2px}
.user-role{font-size:12px;opacity:.8;font-weight:500;text-transform:uppercase;letter-spacing:.5px}
.user-name{font-size:16px;font-weight:600}
.btn-logout{background:rgba(255,255,255,.15);backdrop-filter:blur(10px);color:white;border:2px solid rgba(255,255,255,.3);padding:10px 24px;border-radius:12px;cursor:pointer;font-size:14px;font-weight:600;transition:all .3s ease;display:flex;align-items:center;gap:8px}
.btn-logout:hover{background:rgba(255,255,255,.25);border-color:rgba(255,255,255,.5);transform:translateY(-2px)}

/* ── LAYOUT ── */
.container{max-width:1400px;margin:0 auto;padding:40px 48px}

/* ── TOP NAV ── */
.top-nav{display:flex;justify-content:space-between;align-items:center;margin-bottom:32px;flex-wrap:wrap;gap:12px}
.back-btn{display:inline-flex;align-items:center;gap:8px;background:white;color:#004643;border:2px solid #e2e8f0;padding:10px 20px;border-radius:12px;font-size:14px;font-weight:600;cursor:pointer;text-decoration:none;transition:all .2s;box-shadow:0 1px 4px rgba(0,0,0,.06)}
.back-btn:hover{border-color:#004643;box-shadow:0 3px 10px rgba(0,70,67,.15)}

/* ── PAGE HEADER ── */
.page-header{margin-bottom:32px}
.page-title{font-size:32px;font-weight:800;color:#1e293b;margin-bottom:6px;display:flex;align-items:center;gap:14px}
.page-title i{color:#004643}
.page-description{font-size:15px;color:#64748b}

/* ── SELECTION FORM ── */
.selection-form{background:white;border-radius:24px;padding:36px;box-shadow:0 4px 24px rgba(0,0,0,.06);border:1px solid #e8f0f8}
.form-section{margin-bottom:32px}
.form-section-title{font-size:12px;font-weight:800;color:#64748b;margin-bottom:18px;display:flex;align-items:center;gap:8px;text-transform:uppercase;letter-spacing:.8px;padding-bottom:10px;border-bottom:2px solid #f1f5f9}
.form-section-title i{color:#004643;font-size:13px}

/* ── REPORT TYPE ── */
.report-types{display:grid;grid-template-columns:repeat(4,1fr);gap:14px}
@media(max-width:900px){.report-types{grid-template-columns:repeat(2,1fr)}}
.report-type-option{position:relative}
.report-type-option input[type="radio"]{position:absolute;opacity:0;width:0}
.report-type-label{display:flex;flex-direction:column;align-items:center;padding:22px 16px;border:2px solid #e2e8f0;border-radius:16px;cursor:pointer;transition:all .25s;background:#fafafa;gap:10px}
.report-type-label:hover{border-color:#99f6e4;background:#f0fdfa}
.rt-icon{width:52px;height:52px;border-radius:14px;background:#f1f5f9;display:flex;align-items:center;justify-content:center;font-size:22px;color:#94a3b8;transition:all .25s}
.report-type-label span{font-size:13px;font-weight:700;color:#64748b;text-align:center}
.report-type-option input[type="radio"]:checked+.report-type-label{border-color:#004643;background:#f0fdfa;box-shadow:0 0 0 4px rgba(0,70,67,.08)}
.report-type-option input[type="radio"]:checked+.report-type-label .rt-icon{background:#004643;color:white}
.report-type-option input[type="radio"]:checked+.report-type-label span{color:#004643}

/* ── SELECT ALL BAR ── */
.select-all-bar{display:flex;align-items:center;gap:12px;background:linear-gradient(135deg,#f0fdfa 0%,#ecfdf5 100%);border:2px solid #99f6e4;border-radius:14px;padding:14px 20px;margin-bottom:18px;flex-wrap:wrap}
.select-all-bar span{font-size:12px;font-weight:800;color:#004643;text-transform:uppercase;letter-spacing:.6px;margin-right:4px}
.sa-btn{display:inline-flex;align-items:center;gap:7px;padding:8px 18px;border-radius:10px;font-size:13px;font-weight:700;cursor:pointer;border:2px solid transparent;transition:all .2s;font-family:inherit}
.sa-btn-all{background:#004643;color:white;border-color:#004643}
.sa-btn-all:hover{background:#003330;transform:translateY(-1px);box-shadow:0 4px 12px rgba(0,70,67,.25)}
.sa-btn-none{background:white;color:#64748b;border-color:#e2e8f0}
.sa-btn-none:hover{border-color:#94a3b8;background:#f8fafc}

/* ── GRADE GRID ── */
.grade-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:16px}
@media(max-width:900px){.grade-grid{grid-template-columns:repeat(2,1fr)}}
@media(max-width:600px){.grade-grid{grid-template-columns:1fr}}
.grade-row-label{grid-column:1/-1;font-size:11px;font-weight:800;color:#94a3b8;text-transform:uppercase;letter-spacing:1.2px;padding:10px 0 6px;display:flex;align-items:center;gap:8px}
.grade-row-label::after{content:'';flex:1;height:1px;background:#e2e8f0}
.grade-card{background:white;border-radius:16px;padding:20px;border:2px solid #e2e8f0;transition:all .25s;box-shadow:0 1px 4px rgba(0,0,0,.04)}
.grade-card:hover{border-color:#cbd5e1;box-shadow:0 4px 12px rgba(0,0,0,.07)}
.grade-card.selected{border-color:#004643;box-shadow:0 0 0 4px rgba(0,70,67,.08)}
.grade-card-header{display:flex;align-items:center;gap:12px;margin-bottom:14px;padding-bottom:12px;border-bottom:1px solid #f1f5f9}
.grade-checkbox{width:18px;height:18px;cursor:pointer;accent-color:#004643}
.grade-label{font-size:15px;font-weight:700;color:#1e293b;display:flex;align-items:center;gap:10px;flex:1;cursor:pointer}
.grade-badge{width:34px;height:34px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:800;color:white;flex-shrink:0}
.sections-list{display:flex;flex-direction:column;gap:6px}
.section-checkbox-wrapper{display:flex;align-items:center;gap:10px;padding:8px 12px;border-radius:10px;background:#f8fafc;border:1px solid #f1f5f9;transition:all .2s;cursor:pointer}
.section-checkbox-wrapper:hover{background:#f0fdfa;border-color:#99f6e4}
.section-checkbox{width:15px;height:15px;cursor:pointer;accent-color:#004643;flex-shrink:0}
.section-label{font-size:13px;color:#475569;font-weight:500;flex:1;cursor:pointer;display:flex;align-items:center;gap:7px}
.section-label i{color:#94a3b8;font-size:11px}

/* ── BUTTONS ── */
.form-actions{display:flex;gap:12px;justify-content:flex-end;padding-top:28px;border-top:2px solid #f1f5f9;margin-top:32px}
.btn{padding:12px 28px;border-radius:12px;font-size:14px;font-weight:700;cursor:pointer;transition:all .25s;display:inline-flex;align-items:center;gap:8px;border:none;font-family:inherit}
.btn-generate{background:#004643;color:white;box-shadow:0 2px 8px rgba(0,70,67,.2)}
.btn-generate:hover{background:#003330;transform:translateY(-2px);box-shadow:0 6px 18px rgba(0,70,67,.3)}
.btn-print{background:#7c3aed;color:white;box-shadow:0 2px 8px rgba(124,58,237,.2)}
.btn-print:hover{background:#6d28d9;transform:translateY(-2px);box-shadow:0 6px 18px rgba(124,58,237,.3)}
.btn-secondary{background:#f1f5f9;color:#475569}
.btn-secondary:hover{background:#e2e8f0}

/* ── PREVIEW ACTIONS ── */
.preview-actions{display:flex;gap:12px;margin-bottom:28px;flex-wrap:wrap}

/* ── REPORT DOCUMENT ── */
.report-preview{background:white;border-radius:24px;padding:48px;box-shadow:0 4px 24px rgba(0,0,0,.07);border:1px solid #e8f0f8}
.report-header{text-align:center;margin-bottom:40px;padding-bottom:28px;border-bottom:3px solid #004643;position:relative}
.report-header::after{content:'';position:absolute;bottom:-6px;left:50%;transform:translateX(-50%);width:60px;height:3px;background:#ca8a04;border-radius:2px}
.report-logo{width:80px;height:80px;margin:0 auto 16px}
.report-logo img{width:100%;height:100%;object-fit:contain}
.report-school{font-size:22px;font-weight:800;color:#1e293b;margin-bottom:8px}
.report-type-pill{display:inline-block;background:#004643;color:white;font-size:11px;font-weight:700;padding:4px 14px;border-radius:20px;letter-spacing:.5px;margin-bottom:10px;text-transform:uppercase}
.report-meta{font-size:13px;color:#94a3b8;display:flex;justify-content:center;gap:20px;flex-wrap:wrap;margin-top:8px}
.report-meta span{display:flex;align-items:center;gap:6px}

/* ── GRADE SECTION ── */
.grade-section{margin-bottom:48px}
.grade-section-header{display:flex;align-items:center;gap:14px;padding:16px 24px;border-radius:14px;margin-bottom:24px;color:white}
.gs-icon{width:44px;height:44px;border-radius:12px;background:rgba(255,255,255,.2);display:flex;align-items:center;justify-content:center;font-size:16px;font-weight:900}
.gs-label{font-size:20px;font-weight:800}
.gs-count{margin-left:auto;font-size:13px;opacity:.8}

/* ── SECTION BLOCK ── */
.section-report{margin-bottom:28px;border-radius:16px;border:1px solid #e2e8f0;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,.04)}
.section-report-header{background:#f8fafc;padding:14px 22px;border-bottom:2px solid #e2e8f0;display:flex;align-items:center;gap:10px}
.section-report-title{font-size:16px;font-weight:700;color:#1e293b}
.section-badge{margin-left:auto;font-size:11px;font-weight:700;background:#004643;color:white;padding:3px 10px;border-radius:20px;white-space:nowrap}
.section-body{padding:22px}

/* ── TABLE GROUP ── */
.table-group{margin-bottom:28px}
.table-group:last-child{margin-bottom:0}
.table-title{font-size:12px;font-weight:800;color:#475569;margin-bottom:10px;display:flex;align-items:center;gap:8px;text-transform:uppercase;letter-spacing:.6px}
.table-title i{color:#004643}
.count-badge{margin-left:auto;font-size:11px;font-weight:700;background:#f1f5f9;color:#64748b;padding:2px 10px;border-radius:20px}

/* ── DATA TABLE ── */
.report-table{width:100%;border-collapse:collapse;font-size:12.5px;border-radius:10px;overflow:hidden}
.report-table thead tr{background:#1e293b;color:white}
.report-table th{padding:10px 12px;text-align:left;font-weight:700;font-size:11px;text-transform:uppercase;letter-spacing:.4px;white-space:nowrap}
.report-table td{padding:9px 12px;border-bottom:1px solid #f1f5f9;color:#334155;vertical-align:middle}
.report-table tbody tr:last-child td{border-bottom:none}
.report-table tbody tr:nth-child(even){background:#f8fafc}
.report-table tbody tr:hover{background:#f0fdfa}
.td-name{font-weight:600;color:#1e293b}
.td-center{text-align:center}
.td-num{text-align:center;font-weight:700;font-size:13px;color:#004643}
.td-zero{color:#cbd5e1!important;font-weight:400!important}

/* ── SECTION SUMMARY (Students) ── */
.student-summary-block{background:linear-gradient(135deg,#eff6ff 0%,#dbeafe 100%);border:1px solid #93c5fd;border-radius:14px;padding:22px;margin-top:20px}
.student-summary-title{font-size:12px;font-weight:800;color:#1d4ed8;margin-bottom:16px;display:flex;align-items:center;gap:8px;text-transform:uppercase;letter-spacing:.6px}
.summary-stats-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(120px,1fr));gap:12px}
.summary-stat-card{background:white;border-radius:10px;padding:14px 16px;text-align:center;border:1px solid #bfdbfe;box-shadow:0 1px 3px rgba(0,0,0,.05)}
.summary-stat-value{font-size:28px;font-weight:800;color:#1d4ed8;line-height:1}
.summary-stat-label{font-size:11px;font-weight:600;color:#64748b;margin-top:4px;text-transform:uppercase;letter-spacing:.4px}
.summary-stat-card.male .summary-stat-value{color:#0284c7}
.summary-stat-card.female .summary-stat-value{color:#e11d48}
.summary-stat-card.total .summary-stat-value{color:#004643}

/* ── SECTION SUMMARY (Supplies) ── */
.supplies-summary-block{background:linear-gradient(135deg,#fffbeb 0%,#fef9c3 100%);border:1px solid #fde68a;border-radius:14px;padding:22px;margin-top:20px}
.supplies-summary-title{font-size:12px;font-weight:800;color:#92400e;margin-bottom:16px;display:flex;align-items:center;gap:8px;text-transform:uppercase;letter-spacing:.6px}
.supplies-summary-table{width:100%;border-collapse:collapse;font-size:12px;border-radius:10px;overflow:hidden}
.supplies-summary-table thead tr{background:#92400e}
.supplies-summary-table th{color:white;padding:9px 10px;text-align:center;font-weight:700;font-size:11px;text-transform:uppercase;letter-spacing:.3px}
.supplies-summary-table th:first-child{text-align:left;padding-left:14px}
.supplies-summary-table td{padding:8px 10px;text-align:center;border-bottom:1px solid #fde68a;color:#78350f;font-weight:600}
.supplies-summary-table td:first-child{text-align:left;padding-left:14px;font-weight:700;color:#1e293b}
.supplies-summary-table tbody tr:nth-child(even){background:rgba(255,255,255,.6)}
.supplies-summary-table tbody tr:last-child td{border-bottom:none}
.sup-total{background:#92400e;color:white!important;font-weight:800!important}
.sup-zero{color:#cbd5e1!important;font-weight:400!important}

/* ── SIZE SUMMARY (Uniforms) ── */
.size-summary-block{background:linear-gradient(135deg,#f0fdfa 0%,#ecfdf5 100%);border:1px solid #99f6e4;border-radius:14px;padding:22px;margin-top:20px}
.size-summary-title{font-size:12px;font-weight:800;color:#004643;margin-bottom:16px;display:flex;align-items:center;gap:8px;text-transform:uppercase;letter-spacing:.6px}
.size-summary-table{width:100%;border-collapse:collapse;font-size:12px;border-radius:10px;overflow:hidden}
.size-summary-table thead tr{background:#004643}
.size-summary-table th{color:white;padding:9px 10px;text-align:center;font-weight:700;font-size:11px;text-transform:uppercase;letter-spacing:.3px}
.size-summary-table th:first-child{text-align:left;padding-left:14px}
.size-summary-table td{padding:8px 10px;text-align:center;border-bottom:1px solid #ccfbf1;color:#065f46;font-weight:600}
.size-summary-table td:first-child{text-align:left;padding-left:14px;font-weight:700;color:#1e293b}
.size-summary-table tbody tr:nth-child(even){background:rgba(255,255,255,.6)}
.size-summary-table tbody tr:last-child td{border-bottom:none}
.sz-total{background:#004643;color:white!important;font-weight:800!important}
.size-zero{color:#cbd5e1!important;font-weight:400!important}

/* ── GRADE-LEVEL SUMMARY BLOCK ── */
.grade-summary-wrapper{border-radius:16px;border:2px solid #e2e8f0;overflow:hidden;margin-bottom:32px;box-shadow:0 4px 16px rgba(0,0,0,.06)}
.grade-summary-header{display:flex;align-items:center;gap:12px;padding:14px 22px;color:white;font-size:15px;font-weight:800}
.grade-summary-header i{font-size:16px}
.grade-summary-body{padding:22px;background:#fafcff;display:flex;flex-direction:column;gap:24px}
.grade-summary-section-title{font-size:12px;font-weight:800;color:#475569;margin-bottom:12px;display:flex;align-items:center;gap:8px;text-transform:uppercase;letter-spacing:.6px;padding-bottom:8px;border-bottom:2px solid #e2e8f0}
.grade-summary-section-title i{color:#004643}

/* ── NO DATA ── */
.no-data{text-align:center;padding:40px;color:#94a3b8;display:flex;flex-direction:column;align-items:center;gap:12px}
.no-data i{font-size:36px;opacity:.4}
.no-data p{font-size:14px;font-weight:500}

/* ── PRINT ── */
@media print{
    .no-print{display:none!important}
    body{background:white;font-size:10px}
    .container{padding:12px;max-width:100%}
    .report-preview{border:none;box-shadow:none;padding:0;border-radius:0}
    .grade-section{page-break-before:always}
    .grade-section:first-child{page-break-before:auto}
    .section-report{page-break-inside:avoid;box-shadow:none}
    .size-summary-block,.student-summary-block,.supplies-summary-block,.grade-summary-wrapper{page-break-inside:avoid}
    .report-table thead tr,.grade-section-header,.size-summary-table thead tr,.supplies-summary-table thead tr{-webkit-print-color-adjust:exact;print-color-adjust:exact}
}
@media(max-width:768px){
    .header-content{flex-direction:column;gap:20px}
    .container{padding:24px 20px}
    .report-preview{padding:24px}
    .report-types{grid-template-columns:repeat(2,1fr)}
    .summary-stats-grid{grid-template-columns:repeat(2,1fr)}
}
</style>
</head>
<body>

<div class="header no-print">
    <div class="header-content">
        <div class="header-left">
            <div class="school-logo-header">
                <img src="logo.png" alt="Palatiw Elementary School Logo" onerror="this.style.display='none'" />
            </div>
            <div class="school-info">
                <div class="school-name">Palatiw Elementary School</div>
                <div class="school-subtitle">Consolidated Report System</div>
            </div>
        </div>
        <div class="header-right">
            <div class="user-info">
                <div class="user-role">Administrator</div>
                <div class="user-name"><?php echo htmlspecialchars($_SESSION['username']); ?></div>
            </div>
            <button class="btn-logout" onclick="location.href='logout.php'">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>
</div>

<div class="container">
<?php if (!$show_report): ?>

<div class="top-nav no-print">
    <a href="admin_dashboard.php" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
</div>
<div class="page-header no-print">
    <h1 class="page-title"><i class="fas fa-print"></i> Generate Consolidated Report</h1>
    <p class="page-description">Choose a report type, then select which grades and sections to include.</p>
</div>

<form method="POST" class="selection-form no-print">

    <!-- Report Type -->
    <div class="form-section">
        <div class="form-section-title"><i class="fas fa-sliders-h"></i> Report Type</div>
        <div class="report-types">
            <div class="report-type-option">
                <input type="radio" id="rt_students" name="report_type" value="students" checked>
                <label for="rt_students" class="report-type-label">
                    <div class="rt-icon"><i class="fas fa-users"></i></div><span>Students Only</span>
                </label>
            </div>
            <div class="report-type-option">
                <input type="radio" id="rt_supplies" name="report_type" value="supplies">
                <label for="rt_supplies" class="report-type-label">
                    <div class="rt-icon"><i class="fas fa-boxes"></i></div><span>Supplies Only</span>
                </label>
            </div>
            <div class="report-type-option">
                <input type="radio" id="rt_uniforms" name="report_type" value="uniforms">
                <label for="rt_uniforms" class="report-type-label">
                    <div class="rt-icon"><i class="fas fa-tshirt"></i></div><span>Uniforms Only</span>
                </label>
            </div>
            <div class="report-type-option">
                <input type="radio" id="rt_all" name="report_type" value="all">
                <label for="rt_all" class="report-type-label">
                    <div class="rt-icon"><i class="fas fa-clipboard-list"></i></div><span>Complete Report</span>
                </label>
            </div>
        </div>
    </div>

    <!-- Grade & Section Selection -->
    <div class="form-section">
        <div class="form-section-title"><i class="fas fa-graduation-cap"></i> Select Grades &amp; Sections</div>
        <!-- Select All / Deselect All bar -->
        <div class="select-all-bar">
            <span><i class="fas fa-mouse-pointer"></i> Quick Select:</span>
            <button type="button" class="sa-btn sa-btn-all" onclick="selectAllGrades()">
                <i class="fas fa-check-double"></i> Select All Grades &amp; Sections
            </button>
            <button type="button" class="sa-btn sa-btn-none" onclick="deselectAllGrades()">
                <i class="fas fa-times"></i> Deselect All
            </button>
        </div>
        <div class="grade-grid">
            <div class="grade-row-label"><i class="fas fa-layer-group"></i>&nbsp; Lower Grades (1–3)</div>
            <?php foreach ([1,2,3] as $g): ?>
            <?php if (!empty($available_sections[$g])): ?>
            <div class="grade-card" id="grade-card-<?= $g ?>">
                <div class="grade-card-header">
                    <input type="checkbox" class="grade-checkbox" id="grade-<?= $g ?>"
                           name="grades[]" value="<?= $g ?>" onchange="toggleGrade(<?= $g ?>)">
                    <label for="grade-<?= $g ?>" class="grade-label">
                        <div class="grade-badge" style="background:<?= $grade_colors[$g] ?>">G<?= $g ?></div>
                        Grade <?= $g ?>
                    </label>
                </div>
                <div class="sections-list">
                    <?php foreach ($available_sections[$g] as $sec): ?>
                    <div class="section-checkbox-wrapper">
                        <input type="checkbox" class="section-checkbox section-<?= $g ?>"
                               id="sec-<?= $g ?>-<?= htmlspecialchars($sec['table']) ?>"
                               name="sections_<?= $g ?>[]" value="<?= htmlspecialchars($sec['table']) ?>"
                               onchange="updateGradeCheckbox(<?= $g ?>)">
                        <label for="sec-<?= $g ?>-<?= htmlspecialchars($sec['table']) ?>" class="section-label">
                            <i class="fas fa-folder"></i><?= htmlspecialchars($sec['name']) ?>
                        </label>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>
            <?php endforeach; ?>

            <div class="grade-row-label"><i class="fas fa-layer-group"></i>&nbsp; Upper Grades (4–6)</div>
            <?php foreach ([4,5,6] as $g): ?>
            <?php if (!empty($available_sections[$g])): ?>
            <div class="grade-card" id="grade-card-<?= $g ?>">
                <div class="grade-card-header">
                    <input type="checkbox" class="grade-checkbox" id="grade-<?= $g ?>"
                           name="grades[]" value="<?= $g ?>" onchange="toggleGrade(<?= $g ?>)">
                    <label for="grade-<?= $g ?>" class="grade-label">
                        <div class="grade-badge" style="background:<?= $grade_colors[$g] ?>">G<?= $g ?></div>
                        Grade <?= $g ?>
                    </label>
                </div>
                <div class="sections-list">
                    <?php foreach ($available_sections[$g] as $sec): ?>
                    <div class="section-checkbox-wrapper">
                        <input type="checkbox" class="section-checkbox section-<?= $g ?>"
                               id="sec-<?= $g ?>-<?= htmlspecialchars($sec['table']) ?>"
                               name="sections_<?= $g ?>[]" value="<?= htmlspecialchars($sec['table']) ?>"
                               onchange="updateGradeCheckbox(<?= $g ?>)">
                        <label for="sec-<?= $g ?>-<?= htmlspecialchars($sec['table']) ?>" class="section-label">
                            <i class="fas fa-folder"></i><?= htmlspecialchars($sec['name']) ?>
                        </label>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php endif; ?>
            <?php endforeach; ?>
        </div>
    </div>

    <div class="form-actions">
        <button type="reset" class="btn btn-secondary" onclick="resetForm()"><i class="fas fa-redo"></i> Reset</button>
        <button type="submit" name="generate_report" class="btn btn-generate"><i class="fas fa-file-alt"></i> Generate Report</button>
    </div>
</form>

<?php else: ?>

<div class="preview-actions no-print">
    <button onclick="window.print()" class="btn btn-print"><i class="fas fa-print"></i> Print / Save PDF</button>
    <a href="consolidated_report.php" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Selection</a>
</div>

<div class="report-preview">
    <!-- Document header -->
    <div class="report-header">
        <div class="report-logo"><img src="logo.png" alt="School Logo" onerror="this.style.display='none'"></div>
        <div class="report-school">Palatiw Elementary School</div>
        <?php
        $rt_labels = ['students'=>'Student List','supplies'=>'School Supplies','uniforms'=>'Uniforms','all'=>'Complete Report'];
        echo '<div class="report-type-pill">' . ($rt_labels[$report_type_selected] ?? 'Report') . '</div>';
        ?>
        <div class="report-meta">
            <span><i class="fas fa-calendar-alt"></i> <?= date('F d, Y') ?></span>
            <span><i class="fas fa-clock"></i> <?= date('h:i A') ?></span>
            <span><i class="fas fa-user-shield"></i> <?= htmlspecialchars($_SESSION['username']) ?></span>
        </div>
    </div>

    <?php foreach ($report_data as $grade => $sections): ?>
    <?php
    // ── Compute Grade-Level Aggregates ──────────────────────────────────────
    $grade_total_students = 0;
    $grade_total_male     = 0;
    $grade_total_female   = 0;

    // supplies: section_name => [item => total]
    $grade_supplies_by_section = []; // ['SectionName' => ['notebooks'=>N, ...]]
    $grade_supplies_totals     = array_fill_keys(array_keys($supplies_labels), 0);

    // uniforms: col => merged sizes
    $all_sizes_list = ['XS','S','M','L','XL','XXL','Other'];
    $grade_uniform_sizes = [];
    foreach (array_keys($uniform_col_labels) as $col) {
        $grade_uniform_sizes[$col] = array_fill_keys($all_sizes_list, 0);
    }
    $grade_total_uniforms = 0;

    foreach ($sections as $section) {
        // Students
        $male   = count(array_filter($section['students'], fn($s) => strtoupper($s['gender']) === 'MALE'));
        $female = count($section['students']) - $male;
        $grade_total_students += count($section['students']);
        $grade_total_male     += $male;
        $grade_total_female   += $female;

        // Supplies aggregation per section
        if (!empty($section['supplies'])) {
            $sec_totals = array_fill_keys(array_keys($supplies_labels), 0);
            foreach ($section['supplies'] as $sup) {
                foreach (array_keys($supplies_labels) as $itm) {
                    $sec_totals[$itm] += intval($sup[$itm] ?? 0);
                    $grade_supplies_totals[$itm] += intval($sup[$itm] ?? 0);
                }
            }
            $grade_supplies_by_section[$section['name']] = $sec_totals;
        }

        // Uniforms
        if (!empty($section['uniform_sizes'])) {
            $grade_total_uniforms += count($section['uniforms']);
            foreach (array_keys($uniform_col_labels) as $col) {
                if (!empty($section['uniform_sizes'][$col])) {
                    $grade_uniform_sizes[$col] = mergeSizes($grade_uniform_sizes[$col], $section['uniform_sizes'][$col]);
                }
            }
        }
    }
    ?>

    <div class="grade-section">
        <div class="grade-section-header" style="background:linear-gradient(135deg,<?= $grade_colors[$grade] ?> 0%,<?= $grade_colors[$grade] ?>bb 100%)">
            <div class="gs-icon">G<?= $grade ?></div>
            <div class="gs-label">Grade <?= $grade ?></div>
            <div class="gs-count"><?= count($sections) ?> section<?= count($sections)>1?'s':'' ?></div>
        </div>

        <!-- ════════════════════════════════════════════════════════════
             GRADE-LEVEL SUMMARY (shown before per-section detail)
             ════════════════════════════════════════════════════════════ -->
        <div class="grade-summary-wrapper">
            <div class="grade-summary-header" style="background:<?= $grade_colors[$grade] ?>">
                <i class="fas fa-chart-bar"></i>
                Grade <?= $grade ?> — Overall Summary
            </div>
            <div class="grade-summary-body">

                <?php if ($report_type_selected == 'students' || $report_type_selected == 'all'): ?>
                <!-- Grade Student Summary -->
                <div>
                    <div class="grade-summary-section-title">
                        <i class="fas fa-users"></i> Student Enrollment Summary
                    </div>
                    <div class="summary-stats-grid">
                        <div class="summary-stat-card total">
                            <div class="summary-stat-value"><?= $grade_total_students ?></div>
                            <div class="summary-stat-label">Total Students</div>
                        </div>
                        <div class="summary-stat-card male">
                            <div class="summary-stat-value"><?= $grade_total_male ?></div>
                            <div class="summary-stat-label">♂ Male</div>
                        </div>
                        <div class="summary-stat-card female">
                            <div class="summary-stat-value"><?= $grade_total_female ?></div>
                            <div class="summary-stat-label">♀ Female</div>
                        </div>
                        <div class="summary-stat-card" style="border-color:#e2e8f0">
                            <div class="summary-stat-value" style="color:#64748b"><?= count($sections) ?></div>
                            <div class="summary-stat-label">Sections</div>
                        </div>
                    </div>

                    <!-- Per-section student breakdown -->
                    <div style="margin-top:14px;overflow-x:auto">
                        <table class="report-table">
                            <thead><tr>
                                <th>Section</th>
                                <th class="td-center">Total</th>
                                <th class="td-center">&#9794; Male</th>
                                <th class="td-center">&#9792; Female</th>
                            </tr></thead>
                            <tbody>
                            <?php foreach ($sections as $sec): ?>
                            <?php
                                $sm = count(array_filter($sec['students'], fn($s)=>strtoupper($s['gender'])==='MALE'));
                                $sf = count($sec['students']) - $sm;
                            ?>
                            <tr>
                                <td class="td-name"><?= htmlspecialchars($sec['name']) ?></td>
                                <td class="td-center" style="font-weight:700;color:#004643"><?= count($sec['students']) ?></td>
                                <td class="td-center" style="color:#0284c7;font-weight:600"><?= $sm ?></td>
                                <td class="td-center" style="color:#e11d48;font-weight:600"><?= $sf ?></td>
                            </tr>
                            <?php endforeach; ?>
                            <tr style="background:#1e293b;color:white">
                                <td style="font-weight:700;color:white;padding:10px 12px">TOTAL</td>
                                <td class="td-center" style="font-weight:800;color:white"><?= $grade_total_students ?></td>
                                <td class="td-center" style="font-weight:800;color:#93c5fd"><?= $grade_total_male ?></td>
                                <td class="td-center" style="font-weight:800;color:#fda4af"><?= $grade_total_female ?></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <?php endif; ?>

                <?php if (($report_type_selected == 'supplies' || $report_type_selected == 'all') && !empty($grade_supplies_by_section)): ?>
                <!-- Grade Supplies Summary -->
                <div>
                    <div class="grade-summary-section-title">
                        <i class="fas fa-boxes"></i> School Supplies Summary
                    </div>
                    <div style="overflow-x:auto">
                        <table class="supplies-summary-table">
                            <thead><tr>
                                <th>Section</th>
                                <?php foreach ($supplies_labels as $itm => $lbl): ?>
                                <th><?= $lbl ?></th>
                                <?php endforeach; ?>
                            </tr></thead>
                            <tbody>
                            <?php foreach ($grade_supplies_by_section as $secName => $sec_sup): ?>
                            <tr>
                                <td><?= htmlspecialchars($secName) ?></td>
                                <?php foreach (array_keys($supplies_labels) as $itm): ?>
                                <td class="<?= $sec_sup[$itm]==0?'sup-zero':'' ?>"><?= $sec_sup[$itm]>0?$sec_sup[$itm]:'—' ?></td>
                                <?php endforeach; ?>
                            </tr>
                            <?php endforeach; ?>
                            <!-- Grade Total Row -->
                            <tr>
                                <td class="sup-total">GRADE <?= $grade ?> TOTAL</td>
                                <?php foreach (array_keys($supplies_labels) as $itm): ?>
                                <td class="sup-total"><?= $grade_supplies_totals[$itm] ?></td>
                                <?php endforeach; ?>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <?php endif; ?>

                <?php if (($report_type_selected == 'uniforms' || $report_type_selected == 'all') && $grade_total_uniforms > 0): ?>
                <!-- Grade Uniform Size Summary -->
                <div>
                    <div class="grade-summary-section-title">
                        <i class="fas fa-tshirt"></i> Uniform Size Summary
                    </div>
                    <div style="overflow-x:auto">
                        <table class="size-summary-table">
                            <thead><tr>
                                <th>Uniform Item</th>
                                <?php foreach($all_sizes_list as $sz): ?><th><?= $sz ?></th><?php endforeach; ?>
                                <th>Total</th>
                            </tr></thead>
                            <tbody>
                            <?php foreach($uniform_col_labels as $col => $lbl): ?>
                            <?php $sz_data=$grade_uniform_sizes[$col]; $rt=array_sum($sz_data); ?>
                            <tr>
                                <td><?= $lbl ?></td>
                                <?php foreach($all_sizes_list as $sz): ?>
                                <td class="<?= $sz_data[$sz]==0?'size-zero':'' ?>"><?= $sz_data[$sz]>0?$sz_data[$sz]:'—' ?></td>
                                <?php endforeach; ?>
                                <td class="sz-total"><?= $rt ?></td>
                            </tr>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
                <?php endif; ?>

            </div><!-- /grade-summary-body -->
        </div><!-- /grade-summary-wrapper -->

        <!-- ════════════════════════════════════
             PER-SECTION DETAIL
             ════════════════════════════════════ -->
        <?php foreach ($sections as $section): ?>
        <div class="section-report">
            <div class="section-report-header">
                <i class="fas fa-folder-open" style="color:#004643"></i>
                <div class="section-report-title">Section: <?= htmlspecialchars($section['name']) ?></div>
                <?php $total_rec = count($section['students'])+count($section['supplies'])+count($section['uniforms']); ?>
                <div class="section-badge"><?= $total_rec ?> record<?= $total_rec!=1?'s':'' ?></div>
            </div>
            <div class="section-body">

                <?php if (empty($section['students']) && empty($section['supplies']) && empty($section['uniforms'])): ?>
                <div class="no-data"><i class="fas fa-inbox"></i><p>No data available for this section.</p></div>
                <?php endif; ?>

                <!-- STUDENTS -->
                <?php if (!empty($section['students'])): ?>
                <?php
                    $sec_male   = count(array_filter($section['students'], fn($s)=>strtoupper($s['gender'])==='MALE'));
                    $sec_female = count($section['students']) - $sec_male;
                ?>
                <div class="table-group">
                    <div class="table-title">
                        <i class="fas fa-users"></i> Student List
                        <span class="count-badge"><?= count($section['students']) ?> students</span>
                    </div>
                    <table class="report-table">
                        <thead><tr>
                            <th>#</th><th>LRN</th><th>Full Name</th><th>Gender</th>
                            <th>Age</th><th>Contact No.</th><th>Parent / Guardian</th><th>Parent Contact</th>
                        </tr></thead>
                        <tbody>
                        <?php foreach ($section['students'] as $i => $s): ?>
                        <tr>
                            <td class="td-center" style="color:#94a3b8"><?= $i+1 ?></td>
                            <td style="font-family:monospace;font-size:11px"><?= htmlspecialchars($s['lrn_number']) ?></td>
                            <td class="td-name"><?= htmlspecialchars($s['full_name']) ?></td>
                            <td class="td-center">
                                <?php if(strtoupper($s['gender'])==='MALE'): ?>
                                    <span style="color:#0284c7;font-weight:700;font-size:11px">♂ M</span>
                                <?php else: ?>
                                    <span style="color:#e11d48;font-weight:700;font-size:11px">♀ F</span>
                                <?php endif; ?>
                            </td>
                            <td class="td-center"><?= htmlspecialchars($s['age'] ?? '—') ?></td>
                            <td><?= htmlspecialchars($s['contact_number'] ?? '—') ?></td>
                            <td><?= htmlspecialchars($s['parent_name'] ?? '—') ?></td>
                            <td><?= htmlspecialchars($s['parent_contact'] ?? '—') ?></td>
                        </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>

                    <!-- ── Section Student Summary ── -->
                    <div class="student-summary-block">
                        <div class="student-summary-title">
                            <i class="fas fa-chart-pie"></i>
                            Section Summary — <?= htmlspecialchars($section['name']) ?>
                        </div>
                        <div class="summary-stats-grid">
                            <div class="summary-stat-card total">
                                <div class="summary-stat-value"><?= count($section['students']) ?></div>
                                <div class="summary-stat-label">Total Students</div>
                            </div>
                            <div class="summary-stat-card male">
                                <div class="summary-stat-value"><?= $sec_male ?></div>
                                <div class="summary-stat-label">♂ Male</div>
                            </div>
                            <div class="summary-stat-card female">
                                <div class="summary-stat-value"><?= $sec_female ?></div>
                                <div class="summary-stat-label">♀ Female</div>
                            </div>

                        </div>
                    </div>
                </div>
                <?php endif; ?>

                <!-- SUPPLIES -->
                <?php if (!empty($section['supplies'])): ?>
                <?php
                    // Compute section supplies totals
                    $sec_sup_totals = array_fill_keys(array_keys($supplies_labels), 0);
                    foreach ($section['supplies'] as $sup) {
                        foreach (array_keys($supplies_labels) as $itm) {
                            $sec_sup_totals[$itm] += intval($sup[$itm] ?? 0);
                        }
                    }
                ?>
                <div class="table-group">
                    <div class="table-title">
                        <i class="fas fa-boxes"></i> School Supplies
                        <span class="count-badge"><?= count($section['supplies']) ?> records</span>
                    </div>
                    <table class="report-table">
                        <thead><tr>
                            <th>#</th><th>LRN</th><th>Student Name</th>
                            <th class="td-center">NB</th><th class="td-center">Pad</th><th class="td-center">Bag</th>
                            <th class="td-center">Pen</th><th class="td-center">Pencil</th><th class="td-center">Sharp.</th>
                            <th class="td-center">Crayon</th><th class="td-center">Eraser</th><th class="td-center">Ruler</th>
                            <th class="td-center">Scissors</th><th class="td-center">Glue</th>
                        </tr></thead>
                        <tbody>
                        <?php foreach ($section['supplies'] as $i => $sup): ?>
                        <tr>
                            <td class="td-center" style="color:#94a3b8"><?= $i+1 ?></td>
                            <td style="font-family:monospace;font-size:11px"><?= htmlspecialchars($sup['lrn']) ?></td>
                            <td class="td-name"><?= htmlspecialchars($sup['student_name']) ?></td>
                            <?php foreach(array_keys($supplies_labels) as $itm): ?>
                            <td class="td-num <?= (empty($sup[$itm])||$sup[$itm]=='0')?'td-zero':'' ?>">
                                <?= htmlspecialchars($sup[$itm] ?? '—') ?>
                            </td>
                            <?php endforeach; ?>
                        </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>

                    <!-- ── Section Supplies Summary ── -->
                    <div class="supplies-summary-block">
                        <div class="supplies-summary-title">
                            <i class="fas fa-clipboard-check"></i>
                            Supplies Summary — <?= htmlspecialchars($section['name']) ?>
                        </div>
                        <div style="overflow-x:auto">
                            <table class="supplies-summary-table">
                                <thead><tr>
                                    <th>Item</th>
                                    <th>Total Count</th>
                                    <th>Students w/ Item</th>
                                </tr></thead>
                                <tbody>
                                <?php
                                foreach ($supplies_labels as $itm => $lbl):
                                    $item_total    = $sec_sup_totals[$itm];
                                    $students_with = count(array_filter($section['supplies'], fn($s) => intval($s[$itm] ?? 0) > 0));
                                ?>
                                <tr>
                                    <td><?= $lbl ?></td>
                                    <td class="td-center <?= $item_total==0?'sup-zero':'' ?>" style="font-weight:700;color:#92400e"><?= $item_total > 0 ? $item_total : '—' ?></td>
                                    <td class="td-center" style="color:#16a34a;font-weight:600"><?= $students_with ?></td>
                                </tr>
                                <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <?php endif; ?>

                <!-- UNIFORMS -->
                <?php if (!empty($section['uniforms'])): ?>
                <div class="table-group">
                    <div class="table-title">
                        <i class="fas fa-tshirt"></i> Uniforms
                        <span class="count-badge"><?= count($section['uniforms']) ?> records</span>
                    </div>
                    <table class="report-table">
                        <thead><tr>
                            <th>#</th><th>LRN</th><th>Student Name</th><th class="td-center">Gender</th>
                            <th class="td-center">PE T-Shirt</th><th class="td-center">PE Pants</th>
                            <th class="td-center">Socks</th><th class="td-center">Shoes</th>
                            <th class="td-center">School Uniform</th><th class="td-center">Bottom</th>
                        </tr></thead>
                        <tbody>
                        <?php foreach ($section['uniforms'] as $i => $u): ?>
                        <tr>
                            <td class="td-center" style="color:#94a3b8"><?= $i+1 ?></td>
                            <td style="font-family:monospace;font-size:11px"><?= htmlspecialchars($u['lrn']) ?></td>
                            <td class="td-name"><?= htmlspecialchars($u['student_name']) ?></td>
                            <td class="td-center">
                                <?php if(strtoupper($u['gender'])==='MALE'): ?>
                                    <span style="color:#0284c7;font-weight:700;font-size:11px">♂ M</span>
                                <?php else: ?>
                                    <span style="color:#e11d48;font-weight:700;font-size:11px">♀ F</span>
                                <?php endif; ?>
                            </td>
                            <?php foreach(['pe_tshirt','pe_pants','socks','shoes','school_uniform','uniform_bottom'] as $col): ?>
                            <td class="td-center" style="font-weight:600;color:#004643">
                                <?= htmlspecialchars($u[$col] ?? '—') ?>
                            </td>
                            <?php endforeach; ?>
                        </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>

                    <!-- Section Uniform Size Summary (existing) -->
                    <?php if (!empty($section['uniform_sizes'])): ?>
                    <div class="size-summary-block">
                        <div class="size-summary-title"><i class="fas fa-ruler-horizontal"></i> Size Summary — <?= htmlspecialchars($section['name']) ?></div>
                        <?php $all_sizes = ['XS','S','M','L','XL','XXL','Other']; ?>
                        <table class="size-summary-table">
                            <thead><tr>
                                <th>Uniform Item</th>
                                <?php foreach($all_sizes as $sz): ?><th><?= $sz ?></th><?php endforeach; ?>
                                <th>Total</th>
                            </tr></thead>
                            <tbody>
                            <?php foreach($uniform_col_labels as $col => $lbl): ?>
                            <?php $sz_data=$section['uniform_sizes'][$col]??array_fill_keys($all_sizes,0); $rt=array_sum($sz_data); ?>
                            <tr>
                                <td><?= $lbl ?></td>
                                <?php foreach($all_sizes as $sz): ?>
                                <td class="<?= $sz_data[$sz]==0?'size-zero':'' ?>"><?= $sz_data[$sz]>0?$sz_data[$sz]:'—' ?></td>
                                <?php endforeach; ?>
                                <td class="sz-total"><?= $rt ?></td>
                            </tr>
                            <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                    <?php endif; ?>
                </div>
                <?php endif; ?>

            </div><!-- /section-body -->
        </div><!-- /section-report -->
        <?php endforeach; ?>
    </div><!-- /grade-section -->
    <?php endforeach; ?>
</div><!-- /report-preview -->

<?php endif; ?>
</div><!-- /container -->

<script>
function toggleGrade(grade){
    const cb=document.getElementById('grade-'+grade);
    document.querySelectorAll('.section-'+grade).forEach(s=>s.checked=cb.checked);
    document.getElementById('grade-card-'+grade).classList.toggle('selected',cb.checked);
}
function updateGradeCheckbox(grade){
    const secs=document.querySelectorAll('.section-'+grade);
    let any=false,all=true;
    secs.forEach(s=>{if(s.checked)any=true;else all=false;});
    // Auto-check the grade checkbox whenever at least one section is selected
    document.getElementById('grade-'+grade).checked=any;
    document.getElementById('grade-card-'+grade).classList.toggle('selected',any);
}
function selectAllGrades(){
    document.querySelectorAll('.grade-checkbox').forEach(cb=>{
        cb.checked=true;
        toggleGrade(cb.value);
    });
}
function deselectAllGrades(){
    document.querySelectorAll('.grade-checkbox').forEach(cb=>{
        cb.checked=false;
        toggleGrade(cb.value);
    });
}
function resetForm(){
    document.querySelectorAll('.grade-card').forEach(c=>c.classList.remove('selected'));
    deselectAllGrades();
}
</script>
</body>
</html>
<?php mysqli_close($conn); ?>