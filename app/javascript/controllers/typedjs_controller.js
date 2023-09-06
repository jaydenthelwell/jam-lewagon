import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

// Connects to data-controller="typedjs"
export default class extends Controller {
  connect() {
    console.log("Hello from typedjs")

   new Typed(this.element, {
      strings: ['Jam'],
      typeSpeed: 75,
      startDelay: 100
   })

    document.querySelector(".typed-cursor").classList.add("d-none")
  }
}


