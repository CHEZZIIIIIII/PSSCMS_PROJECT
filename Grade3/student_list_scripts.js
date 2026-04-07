// student_list_scripts.js

// Validation Functions
function validateAge(input) {
    // Remove any non-numeric characters
    input.value = input.value.replace(/[^0-9]/g, '');
    
    // Limit to 2 digits
    if (input.value.length > 2) {
        input.value = input.value.slice(0, 2);
    }
    
    // Ensure age doesn't exceed 20
    let age = parseInt(input.value);
    if (age > 20) {
        input.value = '20';
    }
    
    // Ensure age is at least 1 if not empty
    if (input.value !== '' && age < 1) {
        input.value = '1';
    }
}

function validateContactNumber(input) {
    // Remove any non-numeric characters
    input.value = input.value.replace(/[^0-9]/g, '');
    
    // Limit to exactly 11 digits
    if (input.value.length > 11) {
        input.value = input.value.slice(0, 11);
    }
}

function openAddModal() {
    document.getElementById('modalTitle').innerHTML = '<i class="fas fa-user-plus"></i> Add New Student';
    document.getElementById('formAction').value = 'add';
    document.getElementById('studentForm').reset();
    document.getElementById('studentModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function editStudent(student) {
    document.getElementById('modalTitle').innerHTML = '<i class="fas fa-user-edit"></i> Edit Student';
    document.getElementById('formAction').value = 'edit';
    document.getElementById('studentId').value = student.id;
    document.getElementById('lrn_number').value = student.lrn_number;
    document.getElementById('last_name').value = student.last_name;
    document.getElementById('first_name').value = student.first_name;
    document.getElementById('middle_name').value = student.middle_name;
    document.getElementById('age').value = student.age;
    document.getElementById('gender').value = student.gender;
    document.getElementById('contact_number').value = student.contact_number;
    document.getElementById('parent_name').value = student.parent_name;
    document.getElementById('parent_contact').value = student.parent_contact;
    document.getElementById('studentModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function viewStudent(student) {
    const content = `
        <div class="form-grid">
            <div class="form-group full-width">
                <label>LRN Number</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.lrn_number}</p>
            </div>
            <div class="form-group">
                <label>Last Name</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.last_name}</p>
            </div>
            <div class="form-group">
                <label>First Name</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.first_name}</p>
            </div>
            <div class="form-group">
                <label>Middle Name</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.middle_name}</p>
            </div>
            <div class="form-group">
                <label>Age</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.age}</p>
            </div>
            <div class="form-group">
                <label>Gender</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.gender}</p>
            </div>
            <div class="form-group">
                <label>Contact Number</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.contact_number}</p>
            </div>
            <div class="form-group">
                <label>Parent's Name</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.parent_name}</p>
            </div>
            <div class="form-group full-width">
                <label>Parent's Contact Number</label>
                <p style="padding: 12px; background: #f8fafc; border-radius: 8px; margin: 0; font-weight: 500;">${student.parent_contact}</p>
            </div>
        </div>
    `;
    document.getElementById('viewModalBody').innerHTML = content;
    document.getElementById('viewModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function deleteStudent(id, studentName) {
    if (confirm(`Are you sure you want to delete ${studentName}?\n\nThis action cannot be undone.`)) {
        const urlParams = new URLSearchParams(window.location.search);
        const grade = urlParams.get('grade');
        const section = urlParams.get('section');
        const search = urlParams.get('search') || '';
        const page = urlParams.get('page') || '1';
        
        let deleteUrl = `?grade=${grade}&section=${encodeURIComponent(section)}&delete=${id}`;
        if (search) {
            deleteUrl += `&search=${encodeURIComponent(search)}`;
        }
        deleteUrl += `&page=${page}`;
        
        window.location.href = deleteUrl;
    }
}

function clearSearch() {
    const urlParams = new URLSearchParams(window.location.search);
    const grade = urlParams.get('grade');
    const section = urlParams.get('section');
    window.location.href = `?grade=${grade}&section=${encodeURIComponent(section)}`;
}

function closeModal() {
    document.getElementById('studentModal').style.display = 'none';
    document.body.style.overflow = 'auto';
}

function closeViewModal() {
    document.getElementById('viewModal').style.display = 'none';
    document.body.style.overflow = 'auto';
}

// Close modal when clicking outside
window.onclick = function (event) {
    const modal = document.getElementById('studentModal');
    const viewModal = document.getElementById('viewModal');
    
    if (event.target == modal) {
        closeModal();
    }
    if (event.target == viewModal) {
        closeViewModal();
    }
}

// Close modal on ESC key
document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape') {
        closeModal();
        closeViewModal();
    }
});