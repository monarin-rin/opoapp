// Import and start Turbo and Stimulus
import { Turbo } from "@hotwired/turbo-rails";
Turbo.start();

import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-loading";
import ConfirmDeleteController from "./controllers/confirm_delete_controller";

// Stimulusの初期化
const application = Application.start();
application.register("confirm-delete", ConfirmDeleteController);

// Stimulusコントローラーを自動読み込み
const context = import.meta.globEager("./controllers/**/*.js");
application.load(definitionsFromContext(context));

// Rails UJSを追加
import Rails from "@rails/ujs";
Rails.start();
