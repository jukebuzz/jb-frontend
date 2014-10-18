define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"
  common = require 'common'

  RoomModel = Backbone.Epoxy.Model.extend

    defaults:
      name: ''
      owner_id: ''
      join_token: ''
      active: false

    computeds:
      is_mine:
        deps: ['owner_id']
        get: (owner_id)-> +owner_id is +(common.user.get 'id')

    parse:(r)->
      r.owner_id = r.owner.id
      r
