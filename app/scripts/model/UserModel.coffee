define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"
  common = require 'common'

  UserModel = Backbone.Epoxy.Model.extend

    synced: null
    defaults:
      uid: 0
      name: ""
      email: ""
      avatar_url: ""
      active_balance: 0
      active_room_id: 0

    computeds:
      avatar_url_mini: -> (@get 'avatar_url') + "&s=50"
      logedin: -> +((@get 'uid').length > 0)

    initialize: ->
      @synced = $.Deferred()

    promiseSynced: -> @synced.promise()

    refresh: ->
      common.api.get_current_user()
      .done (data)=>
        @synced.resolve()
        @set data

    #  r
