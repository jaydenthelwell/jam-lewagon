import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="sign-up"
export default class extends Controller {
  static targets = ["input", "prev", "next"];

  connect() {
    console.log(this.inputTargets);
    this.step = 0;

    // console.log("This is birth input")
    // const birthInput = document.querySelector(".users_birthday")
    // console.log(birthInput)

    // flatpickr(birthInput)
  }

  nextContent() {
    console.log(this.inputTargets[this.step])
    this.inputTargets[this.step].classList.add("d-none")
    this.step += 1
    this.inputTargets[this.step].classList.remove("d-none")
    console.log("testing");

    this.prevTarget.classList.remove("transparent")
    // this.nextTarget.classList.remove("transparent")

    console.log(this.step)

    if (this.step == 10) {
      this.nextTarget.classList.add("transparent")
      this.inputTargets[12].classList.remove("d-none")

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

  }
}

// const emailDiv = document.getElementById("page2");

// this.nameTarget.classList.add("d-none");
// this.nameTarget.classList.remove("users_email");

// emailDiv.style.display = "block";
// emailDiv.classList.add("users_email");

// this.birthdateTarget.style.display = "";
// this.birthdateTarget.classList.add("users_birthday");
