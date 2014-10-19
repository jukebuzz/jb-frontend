define (require, exports, module)->
  _List = require "../_List"
  TrackSearchItem = require "../TrackSearchItem/TrackSearchItem"
  TrackCollection = require "collection/TrackCollection"

  TrackSearchList = _List.extend
    template: "#TrackSearchList"
    className: "tracksearch_list"

    ui:
      list: '[data-js-list]'

    bindings:
      "@ui.list": "collection: $collection"

    events:
      "click": "onClick"

    itemView: TrackSearchItem
    initialize: ->
      @collection = new TrackCollection {autoRefresh: false}
      @collection.view = @itemView #if use backbone.epoxy < 1.2

    onClick: -> @trigger "focus"
