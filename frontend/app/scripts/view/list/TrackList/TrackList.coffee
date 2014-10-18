define (require, exports, module)->
  _List = require "../_List"
  TrackItem = require "../TrackItem/TrackItem"


  TrackList = _List.extend
    template: "#TrackList"
    className: "track_list"
    bindings:
      ":el": "collection: $collection"
    itemView: TrackItem
    initialize: ->
      @collection = common.trackCollection
      @collection.view = @itemView #if use backbone.epoxy < 1.2

    setRoom: (id)->
      @collection.refresh(id)

