import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["spinner"];

  connect() {
    this.element.addEventListener("turbo:before-fetch-request", () => {
      this.spinnerTarget.classList.remove("hidden");
    });
    this.element.addEventListener("turbo:load", () => {
      this.spinnerTarget.classList.add("hidden");
    });
  }
} 