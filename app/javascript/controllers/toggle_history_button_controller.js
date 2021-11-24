import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(e) {
    if (e.target.dataset.method === "patch") {
      e.target.dataset.method = "delete"
    } else {
      e.target.dataset.method = "patch"
    }
  }
}
