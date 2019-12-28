document.addEventListener('turbolinks:load', function() {
    let confirm_input = document.querySelector('.confirm-password');
    if (confirm_input) {confirm_input.addEventListener('input', validatePassword)}
});

function validatePassword() {
    let enter_password = document.querySelector('.password'),
        confirm_password = document.querySelector('.confirm-password');
    if (confirm_password.value ==="") {document.querySelector('.text-danger').classList.add('hide');
        document.querySelector('.check').classList.remove('hide')}
    if (enter_password.value !== confirm_password.value) {
        document.querySelector('.check').classList.add('hide');
        document.querySelector('.text-danger').classList.remove('hide')
    } else {
        document.querySelector('.text-danger').classList.add('hide');
        document.querySelector('.check').classList.remove('hide')
    }
}

