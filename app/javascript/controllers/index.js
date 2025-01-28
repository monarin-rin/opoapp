// app/javascript/controllers/index.js
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "stimulus-loading"

const application = Application.start()
const context = require.context(".", true, /\.js$/)
application.load(definitionsFromContext(context))
