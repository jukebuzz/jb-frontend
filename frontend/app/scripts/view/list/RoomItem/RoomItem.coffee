define (require, exports, module)->
  _List = require "../_List"
  ConfirmModal = require "view/modal/ConfirmModal/ConfirmModal"
  common = require 'common'

  RoomItem = _List.extend
    template: "#RoomItem"
    className: "room_item"

    ui:
      before: '[data-js-before]'
      name: '[data-js-name]'
      edit: '[data-js-edit]'
      trash: '[data-js-trash]'

    bindings:
      ':el': 'classes: {active: active}'
      '@ui.name': 'text: name'
      '@ui.before': 'text: before'

    events:
      'click': 'onClick'
      'click @ui.trash': 'onClickTrash'

    computeds:
      before:
        deps: ['is_mine']
        get: (is_mine)->
          if is_mine then '@' else '#'

    onClick: ->
      @model.set {active: true}

    onClickTrash: (e)->
      e.stopPropagation()
      [method, message] = if @model.get 'is_mine'
        ['delete_rooms_id',"Do you want delete this room? After it was deleted all subscriptions and playlist will be deleted too."]
      else
        ['delete_rooms_id_left',"Do you want leave this room?"]
      method =
      modal = new ConfirmModal {question: message}
      modal.showModal().done =>
        (common.api[method] @model.get 'id').done ->
          Backbone.trigger "rooms:needUpdate"



