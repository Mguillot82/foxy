import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'animal', "list"]
  static values = {
    collection: String,
  }

  connect() {
    this.catchId = []
    console.log(this.collectionValue)
    console.log(this.animalTarget)
  }

  revealFormEdit(event) {
    event.preventDefault();
    this.formTarget.classList.remove("d-none");
  }

  revealAnimals(event) {
    event.preventDefault();
    this.animalTarget.classList.remove("d-none")
  }

  selectCatch(e) {
    const index = this.catchId.indexOf(e.params.id)
    if (this.catchId.includes(e.params.id)) {
      this.catchId.splice(index, 1)
    } else {
      this.catchId.push(e.params.id)
    }
    // console.log(this.catchId)
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
      })
  }

  removeCatch(e) {
    e.preventDefault()
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
