define (require, exports, module)->
  _List = require "../_List"
  RoomItem = require "../RoomItem/RoomItem"
  RoomCollection = require "collection/RoomCollection"

  RoomList = _List.extend
    template: "#RoomList"
    className: "room_list"
    bindings:
      "[data-js-list]": "collection: $collection"
    itemView: RoomItem
    initialize: ->
      @collection = new RoomCollection
      @collection.view = @itemView #if use backbone.epoxy < 1.2
