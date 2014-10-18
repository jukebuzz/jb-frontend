define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"

  RoomModel = Backbone.Epoxy.Model.extend

    defaults:
      field:"value"

    #parse:(r)->
    #  r
