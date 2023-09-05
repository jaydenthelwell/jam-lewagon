import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="socials"
export default class extends Controller {
  static targets = ["input", "prev", "next"];

  connect() {
    console.log(this.inputTarget);
    this.step = 0;
  }

  nextContent() {
    console.log(this.inputTarget[this.step])
    this.inputTarget[this.step].classList.add("d-none")
    this.step += 1
    this.inputTarget[this.step].classList.remove("d-none")
    console.log("testing");

    this.prevTarget.classList.remove("transparent")
    // this.nextTarget.classList.remove("transparent")

    console.log(this.step)

    if (this.step == 10) {
      this.nextTarget.classList.add("transparent")
      this.inputTarget[10].classList.remove("d-none")
    }
  }

  prevContent() {
    console.log(this.inputTargets[this.step])
    this.inputTargets[this.step].classList.add("d-none")
    this.step -= 1
    this.inputTargets[this.step].classList.remove("d-none")
    console.log("testing");

    if (this.step == 0) {
      this.prevTarget.classList.add("transparent")
    }
    if (this.step < 10) {
      this.nextTarget.classList.remove("transparent")
      // console.log(this.nextTarget)
    }
  }
}
