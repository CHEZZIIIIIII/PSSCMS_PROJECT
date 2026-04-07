import glob, os
from pathlib import Path

base_path = Path('c:/xampp/htdocs/PALATIW_SYSTEM')
source = base_path / 'Grade1' / 'abokado_supplies.php'
if not source.exists():
    raise FileNotFoundError(source)

content = source.read_text(encoding='utf-8')

# Make generic template from abokado logic
content = content.replace('$grade = 1;', '$grade = {grade};')
content = content.replace("$section = 'Abokado';", "$section = '{section}';")
content = content.replace("if(strtolower($teacher_section) == 'abokado')", "if(strtolower($teacher_section) == strtolower($section))")

# Add computed table names and log section
marker = "$section = '{section}';\n$is_admin = ($_SESSION['usertype'] == 'admin');"
insert = "$section = '{section}';\n$section_db = strtolower(str_replace(' ', '', $section));\n$student_table = 'tblgrade'.$grade.$section_db;\n$supplies_table = $student_table.'supplies';\n$log_section = 'Grade '.$grade.' - '.ucwords(str_replace('_', ' ', $section)).' (Supplies)';\n$is_admin = ($_SESSION['usertype'] == 'admin');"
content = content.replace(marker, insert)

# Replace hard-coded table names with dynamic variables in SQL statements
content = content.replace('FROM tblgrade1abokado', 'FROM {$student_table}')
content = content.replace('SELECT lrn FROM tblgrade1abokadosupplies', 'SELECT lrn FROM {$supplies_table}')
content = content.replace('FROM tblgrade1abokadosupplies', 'FROM {$supplies_table}')
content = content.replace('SELECT id FROM tblgrade1abokadosupplies WHERE lrn = ?', 'SELECT id FROM {$supplies_table} WHERE lrn = ?')
content = content.replace('UPDATE tblgrade1abokadosupplies SET', 'UPDATE {$supplies_table} SET')
content = content.replace('INSERT INTO tblgrade1abokadosupplies', 'INSERT INTO {$supplies_table}')
content = content.replace('DELETE FROM tblgrade1abokadosupplies WHERE id = ?', 'DELETE FROM {$supplies_table} WHERE id = ?')
content = content.replace('SELECT student_name FROM tblgrade1abokadosupplies WHERE id = ?', 'SELECT student_name FROM {$supplies_table} WHERE id = ?')
content = content.replace('SELECT * FROM tblgrade1abokadosupplies WHERE', 'SELECT * FROM {$supplies_table} WHERE')
content = content.replace('SELECT * FROM tblgrade1abokadosupplies ORDER BY student_name', 'SELECT * FROM {$supplies_table} ORDER BY student_name')

# Replace static action log section hard coded strings with log_section variable
content = content.replace("logAction($conn, 'ADD', 'Grade 1 - Abokado (Supplies)',", "logAction($conn, 'ADD', $log_section,")
content = content.replace("logAction($conn, 'EDIT', 'Grade 1 - Abokado (Supplies)',", "logAction($conn, 'EDIT', $log_section,")
content = content.replace("logAction($conn, 'DELETE', 'Grade 1 - Abokado (Supplies)',", "logAction($conn, 'DELETE', $log_section,")

# Replace static display text
content = content.replace('Grade 1 - Abokado School Supplies', 'Grade <?php echo $grade; ?> - <?php echo ucwords(str_replace("_", " ", $section)); ?> School Supplies')

# Create a dynamic copy for each supplies file
files = sorted(glob.glob(str(base_path / 'Grade[1-6]' / '*_supplies.php')))
print('Found', len(files), 'supply files')
for f in files:
    path = Path(f)
    grade = int(path.parent.name.replace('Grade',''))
    section = path.stem.replace('_supplies','')

    final = content.replace('{grade}', str(grade)).replace('{section}', section)

    # Some provision for original template's leftover sections
    # Write out file
    path.write_text(final, encoding='utf-8')
    print('Updated', path)

# Copy Grade1 supplies_scripts.js to all grade directories
src_js = base_path / 'Grade1' / 'supplies_scripts.js'
if src_js.exists():
    for g in range(1,7):
        target_dir = base_path / f'Grade{g}'
        if target_dir.exists():
            (target_dir / 'supplies_scripts.js').write_bytes(src_js.read_bytes())
            print('Copied supplies_scripts.js to', target_dir)

print('Done')
