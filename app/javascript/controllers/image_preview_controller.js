import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["preview"];

  preview(event) {
    const file = event.target.files[0];
    if (!file) {
      this.previewTarget.src = "";
      this.previewTarget.classList.add("hidden");
      return;
    }
    const reader = new FileReader();
    reader.onload = () => {
      this.previewTarget.src = reader.result;
      this.previewTarget.classList.remove("hidden");
    };
    reader.readAsDataURL(file);
  }
} 