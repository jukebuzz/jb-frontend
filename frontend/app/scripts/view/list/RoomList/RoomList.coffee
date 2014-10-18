define (require, exports, module)->
  _List = require "../_List"
  RoomItem = require "../RoomItem/RoomItem"
  RoomCollection = require "collection/RoomCollection"
  RoomAddWidget = require "view/widget/RoomAddWidget/RoomAddWidget"
  common = require "common"

  RoomList = _List.extend
    template: "#RoomList"
    className: "room_list"

    ui:
      add: "[data-js-add]"

    regions:
      add:
        el: '[data-view-add]'
        view: RoomAddWidget

    bindings:
      "[data-js-list]": "collection: $collection"

    events:
      "click @ui.add": "onClickAdd"

    itemView: RoomItem
    initialize: ->
      @collection = new RoomCollection
      @collection.view = @itemView #if use backbone.epoxy < 1.2
      @collection.refresh()
      @listenTo  @collection,'change:active', @onCollectionChangeActive
      @listenTo @r.add, 'needUpdate', @onNeedUpdate

    onCollectionChangeActive: (model, value)->
      return unless value
      id = model.get 'id'
      common.router.navigate "!/rooms/#{id}", {trigger: true}

      # if @collection.

    onClickAdd: -> @r.add.setShow true

    onNeedUpdate: ->
      @collection.refresh()

