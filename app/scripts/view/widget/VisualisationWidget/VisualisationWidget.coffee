define (require, exports, module)->
  _Widget = require "../_Widget"
  Backbone = require "backbone"
  ScreenSketch = require "utils/sketch"
  common = require "common"
  TrackModel = require "model/TrackModel"

  ViewModel = Backbone.Epoxy.Model.extend
    defaults:
      mousemove: false

  VisualisationWidget = _Widget.extend
    template: "#VisualisationWidget"
    className: "visualisation_widget"
    ui:
      "close": "[data-js-close]"
      "artist": "[data-js-artist]"
      "title": "[data-js-title]"

    bindings:
      '@ui.title': 'text: title'
      '@ui.artist': 'text: artist'

    events:
      "click @ui.close": "onClickClose"

    initialize: ->
      @collection = common.trackCollection
      @model = new TrackModel
      @analyser = common.analyser
      @audio = @analyser.getAudio()

    setRoom: (@room_id)->

    onShow: ->
      $(document).on "keydown", @onKeyPress
      @audio.addEventListener 'ended', =>@postTrackPlayed()
      @screen = new ScreenSketch @$el[0], @analyser
      @startPlay()

    postTrackPlayed: ->
      common.api.post_playlist_id_next(@room_id)
        .done (data)=>
          @collection.setData data
          @startPlay()
        .fail => _.delay =>
          @postTrackPlayed()
        , 2000

    asyncGetNext: (async = $.Deferred())->
      if @collection.length > 0
        async.resolve @collection.at 0
      else
        _.delay =>
          @asyncGetNext async
        , 10000
      async.promise()

    startPlay: ->
      @asyncGetNext().done (model)=>
        @model.set model.toJSON()
        @pausePlayer()
        @startPlayer model.get 'stream_url_sc'

    pausePlayer: ->
      @audio.pause()

    startPlayer: (url)->
      @audio.src = url
      @audio.play()

    onClickClose: ->
      Backbone.trigger "vis:toggle", false

    onClose: ->
      $(document).off "keydown", @onKeyPress
      @audio.removeEventListener 'ended'
      @pausePlayer()
      @screen.kill()

    onKeyPress: (e)->
      Backbone.trigger "vis:toggle", false if e.keyCode is 27

