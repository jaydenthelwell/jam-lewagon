import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-genre"
export default class extends Controller {
  static targets = ["genreForm"]
  toggleForm() {
    console.log(this.genreFormTarget)
    this.genreFormTarget.classList.toggle("d-none")
  }
  connect() {
    console.log("hello from toggle")
  }
}
