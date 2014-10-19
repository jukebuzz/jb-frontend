define (require, exports, module)->
  Layout = require "../_Widget"
  Backbone = require "backbone"
  CurrentUserWidget = require "view/widget/CurrentUserWidget/CurrentUserWidget"
  RoomModel = require "model/RoomModel"
  RoomList = require "view/list/RoomList/RoomList"

  class NavigationWidget extends Layout
    template: "#NavigationWidget"
    className: "navigation-widget"
    regions:
      user:
        el: '[data-view-user]'
        view: CurrentUserWidget
      rooms:
        el: '[data-view-rooms]'
        view: RoomList

    ui:
      showVis: "[data-js-show-vis]"

    bindings:
      "@ui.showVis": "toggle: is_mine"

    events:
      "click @ui.showVis": "onClickShowVis"

    initialize: ->
      @model = new RoomModel
      @listenTo @r.rooms, 'change:model', @onRoomChange

    onRoomChange: (model)-> @model.set model.toJSON()

    onClickShowVis: -> Backbone.trigger "vis:toggle", true


