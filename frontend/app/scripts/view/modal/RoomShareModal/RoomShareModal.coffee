define (require, exports, module)->
  _Modal = require "../_Modal"
  RoomShareModal = _Modal.extend
    template: "#RoomShareModal"
    className: "roomshare_modal"

    ui:
      name: '[data-js-name]'
      link: '[data-js-link]'

    bindings:
      '@ui.name': 'text: name'
      '@ui.link': 'value: share_link'

    events:
      'click @ui.link': 'onClickLink'

    onClickLink: ->
      @ui.link.select()

    # initialize: ->
    #  _Modal::initialize.apply this, arguments
     #You code here

    #showModal: ->
    #  #You code here
    #  _Modal::showModal.apply this, arguments
