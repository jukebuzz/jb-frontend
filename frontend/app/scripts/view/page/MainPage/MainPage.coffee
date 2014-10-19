define (require, exports, module)->
  _Page = require "../_Page"
  TrackList = require "view/list/TrackList/TrackList"
  NavigationWidget = require "view/widget/NavigationWidget/NavigationWidget"
  TrackSearchList = require "view/list/TrackSearchList/TrackSearchList"


  MainPage = _Page.extend
    template: "#MainPage"
    className: "main_page"

    ui:
      tracks: "[data-view-tracks]"
      search: "[data-view-search]"

    regions:
      tracks:
        el: '[data-view-tracks]'
        view: TrackList
      navigation:
        el: '[data-view-navigation]'
        view: NavigationWidget
      search:
        el: '[data-view-search]'
        view: TrackSearchList

    showSearch: true

    initialize: ->
      @listenTo @r.tracks, "focus", @onTracksFocus
      @listenTo @r.search, "focus", @onSearchFocus

    onTracksFocus: ->
      @showSearch = false
      @setLayout true

    onSearchFocus: ->
      @showSearch = true
      @setLayout true

    setLayout: (animated=false)->
      if animated
        @ui.search.addClass 'animated'
      transform = if @showSearch
          "translate(0, 0)"
      else
        height = @windowHeight - (46 + 100)
        "translate(0, #{height}px)"
      _.delay =>
        @ui.search.css {transform}
      , 100


    onShow: -> @bindEvents()
    onClose: -> @unbindEvents()

    bindEvents: ->
      @ui.search.on "transitionend webkitTransitionEnd", =>
          @ui.search.removeClass 'animated'
      @__onWindowResize ?= _.bind @onWindowResize, this
      @getWindow().on "resize", @__onWindowResize
      @__onWindowResize()

    unbindEvents: ->
      @ui.search.off "transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd", =>
        @ui.search.removeClass 'animated'
      if @__onWindowResize?
        @getWindow().off "resize", @__onWindowResize

    onWindowResize: ->
      @windowHeight = @getWindow().height()
      @setLayout()

    getWindow: _.memoize -> $ window

    setRoom: (id)->
      @r.tracks.setRoom id
