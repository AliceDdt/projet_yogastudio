import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  connect() {
    this.isValid = false; //test if inputs are correct
  }

	//form validation process
	validate(event) {
    event.preventDefault();
		//reseting error messages
		//this.resetErrors();

		/*fields verification
		errors are pushed into errorTab array*/
		for (const field of this.formFields) {

			this.capitalize(field, 'user[last_name]');
			this.capitalize(field, 'user[first_name]');
			this.capitalize(field, 'user[address_attributes][city]');

			//if field is empty
			if (field.value == '' && field.name != 'user[address_attributes][complementary]') {
        this.checkValidityForField(field, "Champ obligatoire");
			}

			if (field.name == 'user[last_name]' && field.value != '' && !isNaN(field.value)
				|| field.name == 'user[first_name]' && field.value != '' && !isNaN(field.value)) {
          this.checkValidityForField(field, "Nom et/ou prénom ne peuvent pas être numériques !");
			}
		}

		if (user_email.value != '' && !this.emailValidator(user_email.value)) {
      this.checkValidityForField(user_email, "Email non valide !");
		}

		if (user_password.value != '' && !this.pwdValidator(user_password.value)) {
      this.checkValidityForField(user_password, "Le mot de passe doit contenir au moins 8 caractères dont 1 chiffre, 1 majuscule et 1 caractère spécial");
		}

		if (user_password.value != user_password_confirmation.value) {
      this.checkValidityForField(user_password, "Les 2 mots de passe ne correspondent pas");
    }

			//control ok
			if (this.isValid) {
				// this.form.submit();
				// Rails.fire(this.element, 'submit');
			}
		
	}

  get formFields() {
    return Array.from(this.element.elements);
  }

  checkValidityForField (field, message) {
    this.isValid = false;
    field.setCustomValidity(message);
    this.showErrorForInvalidField(field);
  }

  refreshErrorForInvalidField (field, isValid) {
    this.removeExistingErrorMessage(field);
    if (!isValid)
      this.showErrorForInvalidField(field);
  }

  showErrorForInvalidField (field) {
    field.classList.add('error-input');
    field.insertAdjacentHTML('afterend', this.buildFieldErrorHtml(field))
  }

  buildFieldErrorHtml (field) {
    return `<span class="form-error">${field.validationMessage}</span>`
  }

	/*email validation method 
	@params string email
	@returns bool
	*/
	emailValidator(email) {
		const reg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return reg.test(email.toLowerCase());
	}

	/*password validation method 
	@params string password
	@returns bool
	*/
	pwdValidator(password) {
		const regPwd = /^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9])(?=.*\W+)[a-zA-Z0-9\W+]{8,}$/;
		return regPwd.test(password)
	}

	/* capitalize field value 
	@params string field, string name
	@returns string field.value
	*/
	capitalize(field, name) {
		if (field.value != '' && field.name == name) {
			field.value = field.value.charAt(0).toUpperCase() + field.value.slice(1);
			return field.value;
		}
	}

}
