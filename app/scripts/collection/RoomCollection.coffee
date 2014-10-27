define (require, exports, module)->
  Backbone = require "backbone"
  RoomModel = require "model/RoomModel"
  common = require 'common'

  RoomCollection = Backbone.Collection.extend
    model: RoomModel

    defSynced: null

    initialize: ->
      @listenTo this, 'change:active', @onChange
      @defSynced = $.Deferred()

    promiseSynced: -> @defSynced.promise()

    refresh: ->
      common.api.get_rooms()
      .done (data)=>
        @remove @models
        @add data, {parse: true}
        @defSynced.resolve()

    onChange: (model, value)->
      return unless value
      for m in @models  when m isnt model
        m.set {active:false}

    selectItem: (id)->
      @promiseSynced().done =>
        @activeItem = id
        item = @findWhere {id: +id}
        item.set {active: true} if item?

    parse: (r)->
      activeFound = false
      for item in r.rooms when item.id is @activeItem
        item.active = true
        activeFound = true
      delete @activeItem if activeFound
      r.rooms

