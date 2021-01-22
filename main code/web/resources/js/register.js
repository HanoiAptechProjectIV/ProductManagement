
        const username = document.querySelector('#username-register');
        const email = document.querySelector('#email-register');
        const password = document.querySelector('#password-register');
        const repassword = document.querySelector('#re-password-register');
        const fullname = document.querySelector('#fullname-register');
        const phone = document.querySelector('#phone-register');
        const address = document.querySelector('#address-register');
// const username = document.querySelector('#username-register');

        const usernameError = document.querySelector('#username-error');
        const emailError = document.querySelector('#email-error');
        const passwordError = document.querySelector('#password-error');
        const rePasswordError = document.querySelector('#re-password-error');
        const fullNameError = document.querySelector('#fullname-error');
        const phoneError = document.querySelector('#phone-error');
        const addressError = document.querySelector('#address-error');
// const usernameError = document.querySelector('#username-error');

        const submitButton = document.querySelector('#submit-button');
        const myForm = document.querySelector('#my-form');

        const emailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        const passRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/;
        const phoneRegex = /(84|0)+([1-9]{1})([0-9]{8})\b/g;
        const fullNameRegex = /(^[A-Za-z]{3,16})([ ]{0,1})([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})/;

        submitButton.addEventListener('click', (e) => {

            if (checkValid()) {
                myForm.submit();
            } else {
                return;
            }

        });

        const checkValid = () => {
            if (username.value === '') {
                usernameError.textContent = 'Username must not be blank';
                return false;
            } else {
                usernameError.textContent = '';
            }

            if (password.value === '') {
                passwordError.textContent = 'Password must not be blank';
                return false;
            } else if (!passRegex.test(password.value)) {
                passwordError.textContent =
                        'Password must be longer than 8 characters, contain at least 1 number, 1 uppercase and no special character';
                return false;
            } else {
                passwordError.textContent = '';
            }

            if (repassword.value === '') {
                rePasswordError.textContent = 'Password must not be blank';
                return false;
            } else if (repassword.value !== password.value) {
                rePasswordError.textContent = 'Password does not match';
                return false;
            } else {
                rePasswordError.textContent = '';
            }

            if (email.value === '') {
                emailError.textContent = 'Email must not be blank';
                return false;
            } else if (!emailRegex.test(String(email.value).toLocaleLowerCase())) {
                emailError.textContent = 'Invalid email (valid example: -_mY.ownsite12@you.me.com )';
                return false;
            } else {
                emailError.textContent = '';
            }
            
            if (fullname.value === '') {
                fullNameError.textContent = 'Name must not be blank';
                return false;
            } else if(!fullNameRegex.test(fullname.value)){
                fullNameError.textContent = 'Invalid full name (full name must has atleast 2 words with 3 characters each word)';
            } else {
                fullNameError.textContent = '';
            }

            if (phone.value === '') {
                phoneError.textContent = 'Phone must not be blank';
                return false;
            } else if(!phoneRegex.test(phone.value)){
                phoneError.textContent = 'Invalid phone for Vietnamese countries ( start with 0 or 84, next number by 1->9, last 8 numbers by 0->9)';
            } else {
                phoneError.textContent = '';
            }

            return true;
        };
   