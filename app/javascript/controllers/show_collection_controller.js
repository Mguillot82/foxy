import { Controller, fetch } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'animal']

  connect() {
    this.catchId = []
  }

  revealFormEdit(event) {
    event.preventDefault();
    this.formTarget.classList.remove("d-none");
  }

  revealAnimals(event) {
    event.preventDefault();
    this.animalTarget.classList.remove("d-none")
  }

  addCatch(e) {
    this.index = this.catchId.indexOf(e.params.id)
    if (this.catchId.includes(e.params.id)) {
      delete this.catchId[this.index]
    } else {
      this.catchId.push(e.params.id)
    }
    console.log(this.catchId)
    const url = '/'
    fetch()
  }
}
