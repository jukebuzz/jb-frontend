define (require, exports, module)->
  Backbone = require "backbone"
  TrackModel = require "model/TrackModel"
  common = require 'common'

  TrackCollection = Backbone.Collection.extend
    model: TrackModel


    initialize: ({@autoRefresh})->
      if @autoRefresh
        @interval = setInterval (_.bind @refresh, this), 10000

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

