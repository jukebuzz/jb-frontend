define (require, exports, module)->
  _List = require "../_List"
  ConfirmModal = require "view/modal/ConfirmModal/ConfirmModal"
  RoomShareModal = require "view/modal/RoomShareModal/RoomShareModal"
  GithubModal = require "view/modal/GithubModal/GithubModal"
  common = require 'common'

  RoomItem = _List.extend
    template: "#RoomItem"
    className: "room_item"

    ui:
      before: '[data-js-before]'
      name: '[data-js-name]'
      edit: '[data-js-edit]'
      trash: '[data-js-trash]'
      share: '[data-js-share]'
      github: '[data-js-github]'

    bindings:
      ':el': 'classes: {active: active}'
      '@ui.name': 'text: name'
      '@ui.before': 'text: before'
      '@ui.share': 'classes: {visible:is_mine}'
      '@ui.github': 'classes: {visible:is_mine}'

    events:
      'click': 'onClick'
      'click @ui.trash': 'onClickTrash'
      'click @ui.share': 'onClickShare'
      'click @ui.github': 'onClickGithub'

    computeds:
      before:
        deps: ['is_mine']
        get: (is_mine)->
          if is_mine then '@' else '#'

    onClick: ->
      @model.set {active: true}

    onClickShare: ->
      modal = new RoomShareModal {@model}
      modal.showModal()

    onClickGithub: ->
      modal = new GithubModal {@model}
      modal.showModal()

    onClickTrash: (e)->
      e.stopPropagation()
      [method, message] = if @model.get 'is_mine'
        ['delete_rooms_id',"Do you want delete this room? After it was deleted all subscriptions and playlist will be deleted too."]
      else
        ['delete_rooms_id_left',"Do you want leave this room?"]
      modal = new ConfirmModal {question: message}
      modal.showModal().done =>
        (common.api[method] @model.get 'id').done ->
          Backbone.trigger "rooms:needUpdate"



