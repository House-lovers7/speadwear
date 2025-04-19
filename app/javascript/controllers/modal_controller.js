import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    console.log("Modal controller connected");
  }

  open(event) {
    event.preventDefault();
    this.modalTarget.classList.remove("hidden");
  }

  close(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden");
  }
} 