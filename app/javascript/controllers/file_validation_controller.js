import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    console.log("File Validation Controller connected.");
  }

  validate(event) {
    const file = event.target.files[0];
    if (file && file.size > 5242880) { // 5MB in bytes
      alert("Maximum file size is 5MB. Please choose a smaller file.");
      event.target.value = ""; // reset file input
    }
  }
} 