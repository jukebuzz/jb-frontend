define (require, exports, module)->
  _Widget = require "../_Widget"
  Backbone = require "backbone"
  require "epoxy"

  ViewModel = Backbone.Epoxy.Model.extend
    defaults:
      name: ""
      show: false

  RoomAddWidget = _Widget.extend
    template: "#RoomAddWidget"
    className: "roomadd_widget"

    ui:
      name: '[data-js-name]'
      add: '[data-js-add]'
      wrap: '[data-js-wrap]'

    bindings:
      "@ui.name": "value: name, events:['keyup']"
      "@ui.wrap": "toggle: show"

    events:
      "click @ui.add": "onClickAdd"
      "keypress": "onKeypress"

    initialize: ->
      @viewModel = new ViewModel
      @listenTo @viewModel, 'change:show', @onChangeShow

    setShow: ->
      show = not @viewModel.get 'show'
      @viewModel.set {show}

    reset: ->
      @viewModel.set @viewModel.defaults

    onChangeShow: (model, value)->
      return unless value
      _.delay =>
        @ui.name.focus()
      , 200

    onClickAdd: (e)->
      e.preventDefault()
      e.stopPropagation()
      name = @viewModel.get 'name'
      return unless /^[a-z0-9_]+$/.test name
      common.api.post_rooms({name}).done =>
        @reset()
        Backbone.trigger "rooms:needUpdate"

    onKeypress: (e)-> @onClickAdd() if e.keyCode is 13














