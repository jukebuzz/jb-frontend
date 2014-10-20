define (require, exports, module)->
  _Widget = require "../_Widget"
  Backbone = require "backbone"
  ScreenSketch = require "utils/sketch"
  audio = require "utils/audio"
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

    setRoom: (@room_id)->

    onShow: ->
      $(document).on "keydown", @onKeyPress
      audio.done (player)=>
        @player = player
        @startPlay()
        @player.on 'ended', => @postTrackPlayed()

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
      if @screen?
        @screen.kill()
        @screen = null
      @player.pause()

    startPlayer: (url)->
      _.delay =>
          @player.load url
          @screen = new ScreenSketch @$el[0], @player.audio.audio
        , 50

    onClickClose: ->
      Backbone.trigger "vis:toggle", false

    onClose: ->
      $(document).off "keydown", @onKeyPress
      @player.off 'ended'
      @pausePlayer()

    onKeyPress: (e)->
      Backbone.trigger "vis:toggle", false if e.keyCode is 27

