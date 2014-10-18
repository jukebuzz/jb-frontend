define (require, exports, module)->
  _List = require "../_List"
  TrackItem = require "../TrackItem/TrackItem"
  TrackCollection = require "collection/TrackCollection"

  TrackList = _List.extend
    template: "#TrackList"
    className: "track_list"
    bindings:
      ":el": "collection: $collection"
    itemView: TrackItem
    initialize: ->
      @collection = new TrackCollection
      @collection.view = @itemView #if use backbone.epoxy < 1.2

    setRoom: (id)->
      @collection.refresh(id)

