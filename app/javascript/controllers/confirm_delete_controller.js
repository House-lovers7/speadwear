import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    console.log("Confirm Delete controller connected");
  }

  confirm(event) {
    event.preventDefault();
    const url = event.currentTarget.getAttribute("href");
    // Store the URL on the modal's dataset
    this.modalTarget.dataset.deleteUrl = url;
    // Store the item container element for removal after deletion
    this.itemContainer = event.currentTarget.closest('[data-item-id]');
    this.modalTarget.classList.remove("hidden");
  }

  proceed(event) {
    event.preventDefault();
    const url = this.modalTarget.dataset.deleteUrl;
    if (url) {
      fetch(url, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content"),
          "Accept": "application/json"
        }
      }).then(response => {
        if (response.ok) {
          if (this.itemContainer) {
            this.itemContainer.remove();
          } else {
            window.location.reload();
          }
        } else {
          alert("削除に失敗しました");
          this.modalTarget.classList.add("hidden");
        }
      });
    }
    this.modalTarget.classList.add("hidden");
  }

  cancel(event) {
    event.preventDefault();
    this.modalTarget.classList.add("hidden");
  }
} 