define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"
  common = require 'common'

  RoomModel = Backbone.Epoxy.Model.extend

    defaults:
      name: ''
      owner_id: ''
      join_token: ''
      github_token: ''
      active: false

    computeds:
      is_mine:
        deps: ['owner_id']
        get: (owner_id)-> +owner_id is +(common.user.get 'id')
      share_link:
        deps: ['join_token']
        get: (join_token)->
          url = location.protocol + '//' + location.hostname + location.pathname
          url += '#!/roomadd/' + join_token
      github_link:
        deps: ['github_token']
        get: (github_token)->
          url = location.protocol + '//' + location.hostname + "/rooms/github/#{github_token}"


    parse:(r)->
      r.owner_id = r.owner.id
      r
