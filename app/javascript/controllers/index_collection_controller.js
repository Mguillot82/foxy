import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form']

  connect() {
    console.log("Hi it works!!")
  }

  revealFormEdit(event) {
    event.preventDefault();
    this.formTarget.classList.remove("d-none");
  }
}
