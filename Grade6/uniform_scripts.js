// uniform_scripts.js

function validateShoes(input) {
    // Remove non-digits
    var cleaned = input.value.replace(/[^0-9]/g, '');

    if (cleaned === '') {
        input.value = '';
        return;
    }

    var num = parseInt(cleaned, 10);

    if (num > 50) {
        input.value = '50';
    } else if (num < 1) {
        input.value = '1';
    } else {
        input.value = String(num);
    }
}

function updateStudentInfo() {
    const lrnSelect = document.getElementById('lrn');
    const selectedOption = lrnSelect.options[lrnSelect.selectedIndex];
    const studentName = selectedOption.getAttribute('data-name');
    const gender = selectedOption.getAttribute('data-gender');

    document.getElementById('student_name').value = studentName || '';
    document.getElementById('gender').value = gender || '';

    const bottomLabel = document.getElementById('bottom_label');
    if (gender === 'FEMALE') {
        bottomLabel.textContent = 'Skirt';
    } else if (gender === 'MALE') {
        bottomLabel.textContent = 'Slacks';
    } else {
        bottomLabel.textContent = 'Uniform Bottom';
    }
}

function openAddModal() {
    document.getElementById('modalTitle').innerHTML = '<i class="fas fa-tshirt"></i> Add Uniform Record';
    document.getElementById('uniformForm').reset();
    document.getElementById('student_name').value = '';
    document.getElementById('gender').value = '';
    document.getElementById('bottom_label').textContent = 'Uniform Bottom';

    const lrnSelect = document.getElementById('lrn');
    Array.from(lrnSelect.options).forEach(opt => {
        opt.disabled = opt.dataset.taken === 'true';
    });

    lrnSelect.disabled = false;
    document.getElementById('uniformModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function editRecord(record) {
    document.getElementById('modalTitle').innerHTML = '<i class="fas fa-edit"></i> Edit Uniform Record';

    const lrnSelect = document.getElementById('lrn');
    Array.from(lrnSelect.options).forEach(opt => { opt.disabled = false; });

    lrnSelect.value = record.lrn;
    document.getElementById('student_name').value = record.student_name;
    document.getElementById('gender').value = record.gender;
    document.getElementById('pe_tshirt').value = record.pe_tshirt || '';
    document.getElementById('pe_pants').value = record.pe_pants || '';
    document.getElementById('socks').value = record.socks || '';
    document.getElementById('shoes').value = record.shoes || '';
    document.getElementById('school_uniform').value = record.school_uniform || '';
    document.getElementById('uniform_bottom').value = record.uniform_bottom || '';

    const bottomLabel = document.getElementById('bottom_label');
    if (record.gender === 'FEMALE') {
        bottomLabel.textContent = 'Skirt';
    } else if (record.gender === 'MALE') {
        bottomLabel.textContent = 'Slacks';
    }

    Array.from(lrnSelect.options).forEach(opt => {
        if (opt.value !== record.lrn && opt.dataset.taken === 'true') {
            opt.disabled = true;
        }
    });

    lrnSelect.disabled = true;
    document.getElementById('uniformModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function deleteRecord(id, studentName) {
    if (confirm('Are you sure you want to delete the uniform record for ' + studentName + '?\n\nThis action cannot be undone.')) {
        window.location.href = '?delete=' + id;
    }
}

function closeModal() {
    document.getElementById('lrn').disabled = false;
    document.getElementById('uniformModal').style.display = 'none';
    document.body.style.overflow = 'auto';
}

window.onclick = function(event) {
    var modal = document.getElementById('uniformModal');
    if (event.target == modal) closeModal();
};

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') closeModal();
});

document.addEventListener('DOMContentLoaded', function() {
    var lrnSelect = document.getElementById('lrn');
    Array.from(lrnSelect.options).forEach(function(opt) {
        if (opt.disabled) opt.dataset.taken = 'true';
    });
});