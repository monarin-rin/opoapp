import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  confirm(event) {
    if (!confirm("本当に削除しますか？")) {
      event.preventDefault();
    }
  }
}
