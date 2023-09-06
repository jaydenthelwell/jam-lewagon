import { Controller } from "@hotwired/stimulus"
import * as tomSelect from "tom-select";

// Connects to data-controller="tom-select"
export default class extends Controller {
  static values = { options: Object }

  connect() {
    // console.log("hello");
    new TomSelect(
      this.element,
      this.optionsValue,
    );

    console.log(this.optionsValue)
  }
}
