document.addEventListener('turbolinks:load', () => {
    let confirm_input = document.querySelector('.confirm-password');
    if (confirm_input) {confirm_input.addEventListener('change', validatePassword)}
});

function validatePassword() {
    let enter_password = document.querySelector('.password'),
        confirm_password = document.querySelector('.confirm-password');
    if (enter_password.value !== confirm_password.value) {

        document.querySelector('.text-danger').classList.remove('hide')
    } else {
        document.querySelector('.text-danger').classList.add('hide');
        document.querySelector('.check').classList.remove('hide')
    }
}

