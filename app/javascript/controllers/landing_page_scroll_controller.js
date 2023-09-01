import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="landing-page-scroll"
export default class extends Controller {
  static targets = ["secondPage"]

  connect() {
    console.log("Hello from landing page scroll");
  }

  scrollUp() {
    console.log("Scrolling up ...");

    console.log(this.secondPageTarget);

    this.secondPageTarget.classList.add("down");
    this.secondPageTarget.classList.remove("up");
  }

  scrollDown() {
    console.log("Scrolling down ...");

    console.log(this.secondPageTarget);

    this.secondPageTarget.classList.add("up");
    this.secondPageTarget.classList.remove("down");
  }
}

