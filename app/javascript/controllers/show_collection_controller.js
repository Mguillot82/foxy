import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'animal']

  connect() {
    console.log("Hi it works!!")
  }

  revealFormEdit(event) {
    event.preventDefault();
    this.formTarget.classList.remove("d-none");
  }

  revealAnimals(event) {
    event.preventDefault();
    console.log('ca marche pas!')
    this.animalTarget.classList.remove("d-none")
  }
}
