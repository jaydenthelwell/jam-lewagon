import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hide-cards"
export default class extends Controller {
  static targets = ["cards"]
  connect() {
    console.log("hide cards connected")
    setTimeout(() => {
      for (let i = 1; i < this.cardsTargets.length; i++) {
        this.cardsTargets[i].classList.add("d-none")
        console.log(this.cardsTargets)
      }
    }, 500);
  }
}
