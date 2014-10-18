define (require, exports, module)->
  _List = require "../_List"
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
      'click @ui.name': 'onClickName'

    computeds:
      before:
        deps: ['is_mine']
        get: (is_mine)->
          console.log is_mine
          if is_mine then '@' else '#'

    onClickName: ->
      @model.set {active: true}


