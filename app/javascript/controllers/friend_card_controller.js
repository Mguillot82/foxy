// app/javascript/controllers/friend_card_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  removeCard() {
    this.element.remove();
  }
}
