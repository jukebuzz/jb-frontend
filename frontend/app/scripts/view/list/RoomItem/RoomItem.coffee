define (require, exports, module)->
  _List = require "../_List"
  RoomItem = _List.extend
    template: "#RoomItem"
    className: "room_item"
