define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"
  common = require 'common'

  UserModel = Backbone.Epoxy.Model.extend

    defaults:
      name: ""
      email: ""
      avatar: ""
      coins: 0

    refresh: ->
      common.api.get_current_user().done (data)=> @set data

    #  r
