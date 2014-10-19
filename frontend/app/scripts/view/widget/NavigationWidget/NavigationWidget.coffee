define (require, exports, module)->
  Layout = require "../_Widget"
  Backbone = require "backbone"
  CurrentUserWidget = require "view/widget/CurrentUserWidget/CurrentUserWidget"
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

    events:
      "click @ui.showVis": "onClickShowVis"

    onClickShowVis: -> Backbone.trigger "vis:toggle", true


