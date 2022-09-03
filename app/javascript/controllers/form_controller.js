import { Controller } from "@hotwired/stimulus";
import Rails from "@rails/ujs";

// Connects to data-controller="form"
export default class extends Controller {
	static targets = [ "input" ];

  initialize() {
		this.isValid = false; //test if inputs are correct
		this.errors= new Map();
		this.element.setAttribute('novalidate', true)
		this.element.addEventListener('submit', this.onSubmit)
	  this.element.addEventListener("ajax:beforeSend", this.onSubmit);
  }

	onSubmit = (event) => {
		if(!this.isValid){
			event.preventDefault();
			this.validateFields();
			this.focusFirstInvalidField();
		}
	}

	//form validation process
	validateFields() {
		//reseting error messages
		this.resetErrors();

		let password_input = this.inputTargets.find(
      (e) => e.name == "user[password]"
    );

		/*fields verification
		errors are pushed into errorTab array*/
		for (let input of this.inputTargets) {

			this.capitalize(input, "user[last_name]");
			this.capitalize(input, "user[first_name]");
			this.capitalize(input, "user[address_attributes][city]");

			//if field is empty
			if (input.value == '' && input.name != 'user[address_attributes][complementary]') {
				this.createError(input.name,  "Champ obligatoire !");
			}

			else if (input.name == 'user[last_name]' && !isNaN(input.value) 
				|| input.name == 'user[first_name]' && !isNaN(input.value)) {
				this.createError(input.name, "nom et/ou prénom ne peuvent pas être numériques !");
			}

			else if (input.name == "user[email]" && input.value != '' && !this.emailValidator(input.value)) {
				this.createError(input.name, "Email non valide  !");
			}

			else if (input.name == "user[password]" && input.value != '' && !this.pwdValidator(input.value)) {
				this.createError(input.name, "Le mot de passe doit contenir au moins 8 caractères dont 1 chiffre, 1 majuscule et 1 caractère spécial");
			}

			else if (input.name == "user[password_confirmation]" && password_input.value != input.value) {
				this.createError(input.name, "Les 2 mots de passe ne correspondent pas");
			}
		}

			this.showErrors()
		}

	//display errors 
	showErrors() {
		for (let [key, value] of this.errors) {
			let input = this.inputTargets.find((e) => e.name == key);//get the input causing the error
			input.classList.add('error-input');
			input.insertAdjacentHTML("afterend", this.spanErrorHtml(value)); //retrieve span
		}
	}

	//create an error
	createError(field, message) {
		this.isValid = false;//if there is an error isValid is set to false
		this.errors.set(field, message);
	}

	spanErrorHtml(message) {
		return `<span class="form-error">${message}</span>`;
	}

	//delete all errors 
	resetErrors() {
		this.isValid = true; //reseting isValid

		for (let [key, value] of this.errors) {
			let input = this.inputTargets.find((e) => e.name == key);
			input.classList.remove('error-input');
		}

		this.errors.clear(); //empty array

		for (const span of document.querySelectorAll('span.form-error')) {
			span.remove();  //remove span
		}
	}

	focusFirstInvalidField(){
		this.element.querySelector('.error-input').focus()
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
