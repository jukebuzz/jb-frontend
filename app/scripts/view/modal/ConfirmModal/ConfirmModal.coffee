define (require, exports, module)->
  _Modal = require "../_Modal"
  Backbone = require 'backbone'

  ConfirmModal = _Modal.extend
    template: "#ConfirmModal"
    className: "confirm_modal"

    ui:
      question: '[data-js-question]'
      ok: '[data-js-ok]'
      cancel: '[data-js-cancel]'

    bindings:
      '@ui.question': 'text: question'

    events:
      'click @ui.ok': -> @ok()
      'click @ui.cancel': -> @cancel()

    initialize: ({question})->
      _Modal::initialize.apply this, arguments
      @model = new Backbone.Model
      @model.set {question}

    #showModal: ->
    #  #You code here
    #  _Modal::showModal.apply this, arguments
