define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"
  common = require 'common'

  UserModel = Backbone.Epoxy.Model.extend

    defaults:
      name: ""
      email: ""
      avatar_url: ""
      coins: 0

    computeds:
      avatar_url_mini: -> (@get 'avatar_url') + "&s=50"

    refresh: ->
      common.api.get_current_user().done (data)=> @set data

    #  r
