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
      close: '[data-js-close]'

    bindings:
      "@ui.name": "text:name"
      "@ui.coins": "text:active_balance"
      "@ui.avatar": "attr:{src:avatar_url_mini}"

    events:
      "click @ui.close": "onClickClose"

    initialize: ->
      @model = common.user

    onClickClose: ->
      common.api.delete_auth().done ->
        common.router.navigate "", {trigger: true}
