define (require, exports, module)->
  _Page = require "../_Page"
  TrackList = require "view/list/TrackList/TrackList"


  MainPage = _Page.extend
    template: "#MainPage"
    className: "main_page"

    regions:
      tracks:
        el: '[data-view-tracks]'
        view: TrackList


    setRoom: (id)->
      @r.tracks.setRoom id
