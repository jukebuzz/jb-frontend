define (require, exports, module)->
  Backbone = require "backbone"
  RoomModel = require "model/RoomModel"
  common = require 'common'

  RoomCollection = Backbone.Collection.extend
    model: RoomModel

    initialize: ->
      @listenTo this, 'change:active', @onChange

    refresh: ->
      common.api.get_rooms()
      .done (data)=>
        @remove @models
        @add data
        @selectFirst()

    onChange: (model, value)->
      return unless value
      for m in @models  when m isnt model
        m.set {active:false}

    selectFirst: ->
      hasActive = (@where {active:true}).length > 0
      return if hasActive
      @at(0).set active: true

