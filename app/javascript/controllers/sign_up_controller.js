import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sign-up"
export default class extends Controller {
  static targets = ["icon"];

  connect() {
    console.log(this.iconTarget);
  }

  newContent() {
    const nameDiv = this.iconTarget;
    const emailDiv = document.getElementById("page2");

    nameDiv.classList.add("d-none");
    nameDiv.classList.remove("users_email")
    // activates the d-none class so you cant see the name
    // inserts the users_email div
    // this.iconTarget.classList.remove("d-none");
    emailDiv.iconTarget.classList.add("users_email");
    emailDiv.iconTarget.classList.remove("d-none");

    console.log("testing")
    // this.iconTarget.classList.remove("d-none");

  }
}
