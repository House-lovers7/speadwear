import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["panel"];

  toggle(event) {
    event.preventDefault();
    this.panelTarget.classList.toggle("hidden");
  }
} 