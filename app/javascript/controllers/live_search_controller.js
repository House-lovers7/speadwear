import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "input" ];

  initialize() {
    this.timeout = null;
  }

  autoSubmit(event) {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.element.requestSubmit();
    }, 300);
  }
} 