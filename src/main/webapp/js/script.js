/* ====================================================================
   CampusConnect - Client Side Scripts & Helpers
   ==================================================================== */

document.addEventListener('DOMContentLoaded', function() {
    
    // Auto dismiss bootstrap alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(function(alert) {
        setTimeout(function() {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });

    // Password Match Validation helper
    const registerForm = document.getElementById('studentRegisterForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function(event) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                event.preventDefault();
                alert('Passwords do not match! Please check and try again.');
            }
        });
    }
});

// Confirmation dialog for deletion
function confirmDelete(eventName) {
    return confirm("Are you sure you want to delete the event: '" + eventName + "'?\nThis action cannot be undone.");
}
