define (require, exports, module)->
  _List = require "../_List"
  RoomItem = require "../RoomItem/RoomItem"
  RoomCollection = require "collection/RoomCollection"
  common = require "common"

  RoomList = _List.extend
    template: "#RoomList"
    className: "room_list"
    bindings:
      "[data-js-list]": "collection: $collection"
    itemView: RoomItem
    initialize: ->
      @collection = new RoomCollection
      @collection.view = @itemView #if use backbone.epoxy < 1.2
      @collection.refresh()
      @listenTo  @collection,'change:active', @onCollectionChangeActive

    onCollectionChangeActive: (model, value)->
      return unless value
      id = model.get 'id'
      common.router.navigate "!/rooms/#{id}", {trigger: true}

      # if @collection.

