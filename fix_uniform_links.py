import os, re
root = r"c:\xampp\htdocs\PALATIW_SYSTEM"
count=0
for grade_dir in ['Grade1','Grade2','Grade3','Grade4','Grade5','Grade6']:
    dpath = os.path.join(root, grade_dir)
    if not os.path.isdir(dpath):
        continue
    for fname in os.listdir(dpath):
        if fname.endswith('_uniform.php'):
            full = os.path.join(dpath, fname)
            with open(full, 'r', encoding='utf-8') as f:
                text = f.read()
            new_text = text
            if '$section_db' not in new_text:
                lines = new_text.splitlines()
                for i, line in enumerate(lines):
                    if line.strip().startswith('$section ='):
                        insert_line = "$section_db = strtolower(str_replace(' ', '', $section));"
                        if insert_line not in new_text:
                            lines.insert(i+1, insert_line)
                        break
                new_text = '\n'.join(lines)
            new_text = re.sub(r'<title>\s*Uniforms - Grade \d+ [^<]+</title>', '<title>Uniforms - Grade <?php echo $grade; ?> <?php echo ucwords(str_replace("_", " ", $section)); ?></title>', new_text)
            new_text = re.sub(r'<span class="current">[^<]+ - Uniforms</span>', '<span class="current"><?php echo ucwords(str_replace("_", " ", $section)); ?> - Uniforms</span>', new_text)
            new_text = new_text.replace("onclick=\"location.href='abokado_supplies.php'\"", "onclick=\"location.href='<?php echo $section_db; ?>_supplies.php'\"")
            new_text = new_text.replace("onclick=\"location.href='abokado_uniform.php'\"", "onclick=\"location.href='<?php echo $section_db; ?>_uniform.php'\"")
            new_text = new_text.replace("location.href='abokado_uniform.php'", "location.href='<?php echo $section_db; ?>_uniform.php'")
            new_text = new_text.replace("location.href='abokado_supplies.php'", "location.href='<?php echo $section_db; ?>_supplies.php'")
            if new_text != text:
                with open(full, 'w', encoding='utf-8') as f:
                    f.write(new_text)
                count += 1
print('Updated', count, 'uniform files')
