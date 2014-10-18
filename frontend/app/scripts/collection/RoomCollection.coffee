define (require, exports, module)->
  Backbone = require "backbone"
  roomModel = require "model/roomModel"

  RoomCollection = Backbone.Collection.extend
    model: roomModel
