define (require, exports, module)->
  Backbone = require "backbone"
  TrackModel = require "model/TrackModel"
  common = require 'common'

  TrackCollection = Backbone.Collection.extend
    model: TrackModel


    initialize: ({@autoRefresh})->
      @listenTo this, "change:active", @onChangeActive
      if @autoRefresh
        @interval = setInterval (_.bind @refresh, this), 10000

    setSC: (data)->
      @remove @models
      @add data, {parse: true}

    onChangeActive: (model, value)->
      return unless value
      for m in @models when m isnt model
        m.set {active: false}

    refresh: (id=@room_id)->
      return unless id?
      common.api.get_playlist_id_items(id).done (data)=>
        @room_id = id
        @remove @models
        @add data, {parse: true}

    parse: (r)->
      i = 1
      item.number = i++ for item in r
      r

