define (require, exports, module)->
  _List = require "../_List"
  TrackSearchItem = _List.extend
    template: "#TrackSearchItem"
    className: "tracksearch_item"
