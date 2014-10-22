define (require, exports, module)->
  _List = require "../_List"
  TrackSearchItem = require "../TrackSearchItem/TrackSearchItem"
  TrackCollection = require "collection/TrackCollection"
  Backbone = require "backbone"
  common = require 'common'
  require "epoxy"

  ViewModel = Backbone.Epoxy.Model.extend
    defaults:
      search: ""

  TrackSearchList = _List.extend
    template: "#TrackSearchList"
    className: "tracksearch_list"

    ui:
      list: '[data-js-list]'
      input: '[data-js-input]'

    bindings:
      "@ui.list": "collection: $collection"
      "@ui.input": "value: search, events:['keyup']"

    events:
      "click": "onClick"

    itemView: TrackSearchItem
    initialize: ->
      @viewModel = new ViewModel
      @collection = new TrackCollection
      @collection.view = @itemView
      @listenTo @viewModel, "change:search", @onChangeSearch
      @listenTo @collection, "change:active", @onCollectionChangeActive
      @onChangeSearch(@viewModel, @viewModel.get 'search')

    onChangeSearch: _.throttle (model, value)->
      return unless value.length >= 3
      common.api.sc_get_tracks value, 0
      .done (data)=> @collection.setSC data
    , 700

    onCollectionChangeActive: (model, value)->
      return unless value
      common.audio.done (player)->
        model.once 'change:active', -> player.pause()
        player.pause()
        _.delay ->
          player.load model.get 'stream_url_sc'
          player.play()
        , 100

    onClick: -> @trigger "focus"
