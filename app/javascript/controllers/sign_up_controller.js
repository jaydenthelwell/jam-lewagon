import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sign-up"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    console.log(this.inputTargets);
    this.step = 0;
  }

  nextContent() {
    console.log(this.inputTargets[this.step])
    this.inputTargets[this.step].classList.add("d-none")
    this.step += 1
    this.inputTargets[this.step].classList.remove("d-none")
    console.log("testing");

  }

  prevContent() {
    console.log(this.inputTargets[this.step])
    this.inputTargets[this.step].classList.add("d-none")
    this.step -= 1
    this.inputTargets[this.step].classList.remove("d-none")
    console.log("testing");

  }
}
// const emailDiv = document.getElementById("page2");

// this.nameTarget.classList.add("d-none");
// this.nameTarget.classList.remove("users_email");

// emailDiv.style.display = "block";
// emailDiv.classList.add("users_email");

// this.birthdateTarget.style.display = "";
// this.birthdateTarget.classList.add("users_birthday");
