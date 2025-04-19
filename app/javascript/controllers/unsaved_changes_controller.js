import { Controller } from "stimulus";

export default class extends Controller {
  initialize() {
    this.unsaved = false;
  }

  connect() {
    window.addEventListener("beforeunload", this.beforeUnload.bind(this));
    console.log("Unsaved Changes Controller connected.");
  }

  disconnect() {
    window.removeEventListener("beforeunload", this.beforeUnload.bind(this));
  }

  beforeUnload(event) {
    if (this.unsaved) {
      event.preventDefault();
      event.returnValue = "You have unsaved changes. Are you sure you want to leave?";
      return event.returnValue;
    }
  }

  markAsUnsaved() {
    this.unsaved = true;
  }

  formSubmitted() {
    this.unsaved = false;
  }
} 