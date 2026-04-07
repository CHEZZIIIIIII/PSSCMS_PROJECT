// uniform_scripts.js

function validateShoes(input) {
    // Remove any non-numeric characters
    input.value = input.value.replace(/[^0-9]/g, '');

    // Enforce max 2 digits (1-50 range)
    if (input.value.length > 2) {
        input.value = input.value.slice(0, 2);
    }

    // Clamp to 1–50
    if (input.value !== '') {
        let val = parseInt(input.value);
        if (val > 50) input.value = '50';
        if (val < 1 && input.value.length > 0) input.value = '';
    }
}

function updateStudentInfo() {
    const lrnSelect = document.getElementById('lrn');
    const selectedOption = lrnSelect.options[lrnSelect.selectedIndex];
    const studentName = selectedOption.getAttribute('data-name');
    const gender = selectedOption.getAttribute('data-gender');
    
    document.getElementById('student_name').value = studentName || '';
    document.getElementById('gender').value = gender || '';
    
    // Update bottom label based on gender
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

    // Re-enable all options and restore Add mode disabled state (taken ones stay disabled)
    const lrnSelect = document.getElementById('lrn');
    Array.from(lrnSelect.options).forEach(opt => {
        if (opt.dataset.taken === 'true') {
            opt.disabled = true;
        } else {
            opt.disabled = false;
        }
    });

    lrnSelect.disabled = false;
    document.getElementById('uniformModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function editRecord(record) {
    document.getElementById('modalTitle').innerHTML = '<i class="fas fa-edit"></i> Edit Uniform Record';

    const lrnSelect = document.getElementById('lrn');

    // Enable all options temporarily so we can set the current LRN value
    Array.from(lrnSelect.options).forEach(opt => {
        opt.disabled = false;
    });

    lrnSelect.value = record.lrn;
    document.getElementById('student_name').value = record.student_name;
    document.getElementById('gender').value = record.gender;
    document.getElementById('pe_tshirt').value = record.pe_tshirt || '';
    document.getElementById('pe_pants').value = record.pe_pants || '';
    document.getElementById('socks').value = record.socks || '';
    document.getElementById('shoes').value = record.shoes || '';
    document.getElementById('school_uniform').value = record.school_uniform || '';
    document.getElementById('uniform_bottom').value = record.uniform_bottom || '';
    
    // Update bottom label
    const bottomLabel = document.getElementById('bottom_label');
    if (record.gender === 'FEMALE') {
        bottomLabel.textContent = 'Skirt';
    } else if (record.gender === 'MALE') {
        bottomLabel.textContent = 'Slacks';
    }

    // Re-disable taken options (except the current student's own LRN)
    Array.from(lrnSelect.options).forEach(opt => {
        if (opt.value !== record.lrn && opt.dataset.taken === 'true') {
            opt.disabled = true;
        }
    });

    // Lock the LRN dropdown during edit so student can't be changed
    lrnSelect.disabled = true;

    document.getElementById('uniformModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function deleteRecord(id, studentName) {
    if (confirm(`Are you sure you want to delete the uniform record for ${studentName}?\n\nThis action cannot be undone.`)) {
        window.location.href = `?delete=${id}`;
    }
}

function closeModal() {
    // Re-enable LRN dropdown in case it was locked during edit
    document.getElementById('lrn').disabled = false;
    document.getElementById('uniformModal').style.display = 'none';
    document.body.style.overflow = 'auto';
}

// Close modal when clicking outside
window.onclick = function (event) {
    const modal = document.getElementById('uniformModal');
    if (event.target == modal) {
        closeModal();
    }
}

// Close modal on ESC key
document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
        closeModal();
    }
});

// Mark taken options with data-taken attribute on page load for easy reference
document.addEventListener('DOMContentLoaded', function () {
    const lrnSelect = document.getElementById('lrn');
    Array.from(lrnSelect.options).forEach(opt => {
        if (opt.disabled) {
            opt.dataset.taken = 'true';
        }
    });
});