define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"
  common = require 'common'

  UserModel = Backbone.Epoxy.Model.extend

    defaults:
      uid: 0
      name: ""
      email: ""
      avatar_url: ""
      active_balance: 0
      active_room_id: 0

    computeds:
      avatar_url_mini: -> (@get 'avatar_url') + "&s=50"
      logedin: -> +((@get 'email').length < 0)

    refresh: ->
      common.api.get_current_user().done (data)=> @set data

    #  r
