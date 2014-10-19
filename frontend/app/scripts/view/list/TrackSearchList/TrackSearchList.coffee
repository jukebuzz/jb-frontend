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
      search: "funk"

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
      @collection = new TrackCollection {autoRefresh: false}
      @collection.view = @itemView #if use backbone.epoxy < 1.2
      @listenTo @viewModel, "change:search", @onChangeSearch
      @listenTo @collection, "change:active", @onCollectionChangeActive
      @onChangeSearch(@viewModel, @viewModel.get 'search')

    onChangeSearch: _.throttle (model, value)->
      return unless value.length >= 3
      SC.get '/tracks.json',{
        filter: 'streamable',
        order: 'hotness',
        q: value
        'duration[to]': 500000
        limit: 20
        }, (result)=>
          @collection.setSC result
    , 2000

    onCollectionChangeActive: (model, value)->
      return unless value
      stream = model.get 'stream_url'
      common.audio.done (player)->
        model.once 'change:active', -> player.pause()
        player.pause()
        _.delay ->
          player.load stream + '?client_id=e90b73852966e0f8a83b4c4e39d90ab5'
          player.play()
        , 100

    onClick: -> @trigger "focus"
