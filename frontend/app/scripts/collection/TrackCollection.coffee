define (require, exports, module)->
  Backbone = require "backbone"
  TrackModel = require "model/TrackModel"
  common = require 'common'

  TrackCollection = Backbone.Collection.extend
    model: TrackModel

    refresh: (id)->
      common.api.get_playlist_id_items(id).done (data)=>
        @remove @models
        @add data, {parse: true}

    parse: (r)->
      i = 1
      item.number = i++ for item in r
      r

