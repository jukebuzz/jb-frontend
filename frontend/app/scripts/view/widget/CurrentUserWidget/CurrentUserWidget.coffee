define (require, exports, module)->
  _Widget = require "../_Widget"
  common = require "common"
  CurrentUserWidget = _Widget.extend
    template: "#CurrentUserWidget"
    className: "currentuser_widget"

    ui:
      name: '[data-js-name]'
      avatar: '[data-js-avatar]'
      coins: '[data-js-coins]'

    bindings:
      "@ui.name": "text:name"
      "@ui.coins": "text:coins"
      "@ui.avatar": "attr:{src:avatar}"

    initialize: ->
      @model = common.user
