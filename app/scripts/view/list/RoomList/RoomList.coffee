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
      list: "[data-js-list]"

    regions:
      add:
        el: '[data-view-add]'
        view: RoomAddWidget

    bindings:
      "@ui.list": "collection: $collection"

    events:
      "click @ui.add": "onClickAdd"

    itemView: RoomItem
    initialize: ->
      @collection = new RoomCollection
      @collection.view = @itemView #if use backbone.epoxy < 1.2
      @collection.refresh()
      @listenTo  @collection,'change:active', @onCollectionChangeActive
      @listenTo Backbone, 'rooms:needUpdate', @onNeedUpdate
      @listenTo common.router, 'route:rooms', @onRoute

    onCollectionChangeActive: (model, value)->
      return unless value
      @trigger "change:model", model
      id = model.get 'id'
      common.api.post_rooms_id_switch(id).done (data)->
        common.user.refresh()
      common.router.navigate "!/rooms/#{id}", {trigger: true}

    onRoute: (id)-> @collection.selectItem id

    onClickAdd: -> @r.add.setShow true

    onNeedUpdate: (opts={})->
      addItem = opts.addItem
      if addItem?
        @collection.add @collection.model::parse addItem
      else
        @collection.refresh()

