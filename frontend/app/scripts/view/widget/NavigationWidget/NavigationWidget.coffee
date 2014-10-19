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


