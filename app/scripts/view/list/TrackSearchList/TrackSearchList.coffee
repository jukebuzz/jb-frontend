define (require, exports, module)->
  _List = require "../_List"
  TrackSearchItem = require "../TrackSearchItem/TrackSearchItem"
  TrackCollection = require "collection/TrackCollection"
  Backbone = require "backbone"
  common = require 'common'
  require "epoxy"
  require "utils/soundcloud"

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
      @collection.view = @itemView #if use backbone.epoxy < 1.2
      window.collection = @collection
      @listenTo @viewModel, "change:search", @onChangeSearch
      @listenTo @collection, "change:active", @onCollectionChangeActive
      @onChangeSearch(@viewModel, @viewModel.get 'search')

    onChangeSearch: _.throttle (model, value)->
      return unless value.length >= 3
      SC.get '/tracks.json',{
        streamable: true
        filter: 'streamable'
        order: 'hotness'
        license: 'to_share'
        q: value
        'duration[to]': 500000
        limit: 20
        }, (result, error)=>
          return if result is null or error
          @collection.setSC result
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
