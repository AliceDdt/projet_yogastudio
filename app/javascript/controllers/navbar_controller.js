import { Controller } from "@hotwired/stimulus";
// import { useClickOutside } from 'stimulus-use';

export default class extends Controller {
	static targets = [ 'toggable' ];

	// connect() {
  //   useClickOutside(this)
  // }

  // clickOutside(event) {
  //   this.toggableTarget.classList.remove('open');
  // }


	animateNav() {
		 this.toggableTarget.classList.toggle('open');
	}
}
