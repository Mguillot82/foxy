import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'animal', "list", "validate"]
  static values = {
    collection: String,
  }

  connect() {
    this.catchId = []
  }

  revealFormEdit(event) {
    console.log('test')
    event.preventDefault();
    this.formTarget.classList.toggle("d-none");
  }

  revealAnimals(event) {
    event.preventDefault();
    this.animalTarget.classList.toggle("d-none")
    this.validateTarget.classList.toggle("d-none")
  }

  selectCatch(e) {
    const index = this.catchId.indexOf(e.params.id)
    if (this.catchId.includes(e.params.id)) {
      this.catchId.splice(index, 1)
    } else {
      this.catchId.push(e.params.id)
    }
    const select = e.currentTarget
    select.classList.toggle("selected")
  }

  addCatch() {
    const token = document.getElementsByName('csrf-token')[0].content;
    const url = `/collections/${this.collectionValue}/add_catch`
    fetch(url, {
      method: 'POST',
      headers: {
        "Accept": "text/plain",
        "Content-Type": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({'catches': this.catchId})
    })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data
        this.catchId = []
      })
  }

  removeCatch(e) {
    e.stopPropagation()
    alert('Are you sure?')
    const token = document.getElementsByName('csrf-token')[0].content;
    console.log(e)
    const removeCatchId = e.params.id
    const url = `/collections/${this.collectionValue}/remove_catch`
    fetch(url, {
      method: 'DELETE',
      headers: {
        "Accept": "text/plain",
        "Content-Type": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({'catch': removeCatchId})
    })
    .then(response => response.text())
    .then((data) => {
      this.listTarget.innerHTML = data
    })
  }
}
