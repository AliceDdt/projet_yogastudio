import { Controller } from "@hotwired/stimulus";
// import { useClickOutside } from 'stimulus-use';

export default class extends Controller {
	static targets = [ 'toggable' ];

	animateNav() {
		 this.toggableTarget.classList.toggle('open');
	}
}
