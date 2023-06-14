import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="catches-animals"
export default class extends Controller {
  static targets = ['animal', 'catch', 'btnanimal', 'btncatch',]

  connect() {
  }

  catch(event) {
    event.preventDefault();
    console.log(event);
    this.animalTarget.classList.add('d-none');
    this.catchTarget.classList.remove('d-none');
    this.btnanimalTarget.classList.replace('btn-secondary','btn-outline-secondary');
    this.btncatchTarget.classList.replace('btn-outline-secondary', 'btn-secondary');
  }

  animal(event) {
    event.preventDefault();
    console.log(event);
    this.animalTarget.classList.remove('d-none');
    this.catchTarget.classList.add('d-none');
    this.btnanimalTarget.classList.replace('btn-outline-secondary','btn-secondary');
    this.btncatchTarget.classList.replace('btn-secondary', 'btn-outline-secondary');
  }
}
