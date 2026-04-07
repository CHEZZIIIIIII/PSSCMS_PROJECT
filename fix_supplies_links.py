import os, re
root = r"c:\xampp\htdocs\PALATIW_SYSTEM"
pattern_title = re.compile(r'<title>\s*School Supplies - Grade \d+ [^<]+</title>', re.IGNORECASE)
pattern_current = re.compile(r'<span class="current">[^<]+ - School Supplies</span>')
count = 0
for grade_dir in ['Grade1','Grade2','Grade3','Grade4','Grade5','Grade6']:
    dpath = os.path.join(root, grade_dir)
    if not os.path.isdir(dpath):
        continue
    for fname in os.listdir(dpath):
        if fname.endswith('_supplies.php'):
            full = os.path.join(dpath, fname)
            with open(full, 'r', encoding='utf-8') as f:
                text = f.read()
            new_text = text
            new_text = pattern_title.sub('<title>School Supplies - Grade <?php echo $grade; ?> <?php echo ucwords(str_replace("_", " ", $section)); ?></title>', new_text)
            new_text = pattern_current.sub('<span class="current"><?php echo ucwords(str_replace("_", " ", $section)); ?> - School Supplies</span>', new_text)
            new_text = new_text.replace("onclick=\"location.href='abokado_uniform.php'\"", "onclick=\"location.href='<?php echo $section_db; ?>_uniform.php'\"")
            new_text = new_text.replace("onclick=\"location.href='abokado_supplies.php'\"", "onclick=\"location.href='<?php echo $section_db; ?>_supplies.php'\"")
            if new_text != text:
                with open(full, 'w', encoding='utf-8') as f:
                    f.write(new_text)
                count += 1
print('Updated', count, 'supplies files')
