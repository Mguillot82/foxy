import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['name']

  connect() {
    console.log("Hi it works!!")
  }

  revealFormEdit() {
    console.log('yep')
    this.nameTarget.classList.remove("d-none")
  }
}
