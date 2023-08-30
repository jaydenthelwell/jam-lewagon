import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user"
export default class extends Controller {
  static targets = ["icon"];

  connect() {
    console.log("hello");
  }

  newContent() {
    this.iconTarget.classList.remove("d-none")
  }
}
