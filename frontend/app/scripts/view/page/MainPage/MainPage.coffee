define (require, exports, module)->
  _Page = require "../_Page"
  TrackList = require "view/list/TrackList/TrackList"
  NavigationWidget = require "view/widget/NavigationWidget/NavigationWidget"


  MainPage = _Page.extend
    template: "#MainPage"
    className: "main_page"

    regions:
      tracks:
        el: '[data-view-tracks]'
        view: TrackList
      navigation:
        el: '[data-view-navigation]'
        view: NavigationWidget


    setRoom: (id)->
      @r.tracks.setRoom id
