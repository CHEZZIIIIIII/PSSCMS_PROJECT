// supplies_scripts.js

function updateStudentName() {
    const sel = document.getElementById('lrn');
    const name = sel.options[sel.selectedIndex].getAttribute('data-name');
    document.getElementById('student_name').value = name || '';
}

function openAddModal() {
    document.getElementById('modalTitle').innerHTML = '<i class="fas fa-book"></i> Add Supply Record';
    document.getElementById('supplyForm').reset();
    document.getElementById('student_name').value = '';
    document.getElementById('hidden_lrn').value = '';
    document.getElementById('lrn').disabled = false;
    document.getElementById('supplyModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function editRecord(record) {
    document.getElementById('modalTitle').innerHTML = '<i class="fas fa-edit"></i> Edit Supply Record';

    // Set hidden LRN for form submission
    document.getElementById('hidden_lrn').value = record.lrn;

    // Show LRN in dropdown but disable it (LRN shouldn't change on edit)
    const lrnSelect = document.getElementById('lrn');
    lrnSelect.value = record.lrn;
    lrnSelect.disabled = true;

    document.getElementById('student_name').value = record.student_name;
    document.getElementById('notebooks').value = record.notebooks || '';
    document.getElementById('padpaper').value = record.padpaper || '';
    document.getElementById('bag').value = record.bag || '';
    document.getElementById('ballpen').value = record.ballpen || '';
    document.getElementById('pencil').value = record.pencil || '';
    document.getElementById('sharpener').value = record.sharpener || '';
    document.getElementById('crayons').value = record.crayons || '';
    document.getElementById('eraser').value = record.eraser || '';
    document.getElementById('ruler').value = record.ruler || '';
    document.getElementById('scissors').value = record.scissors || '';
    document.getElementById('glue').value = record.glue || '';
    document.getElementById('supplyModal').style.display = 'block';
    document.body.style.overflow = 'hidden';
}

function deleteRecord(id, studentName) {
    if (confirm(`Are you sure you want to delete the supply record for ${studentName}?\n\nThis action cannot be undone.`)) {
        window.location.href = `?delete=${id}`;
    }
}

function closeModal() {
    document.getElementById('supplyModal').style.display = 'none';
    document.body.style.overflow = 'auto';
}

// Close modal when clicking outside
window.onclick = function (event) {
    const modal = document.getElementById('supplyModal');
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