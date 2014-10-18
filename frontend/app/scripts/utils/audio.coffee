define (require)->
  promise = $.Deferred()
  Audio5js = require 'audio5js'
  new Audio5js
    swf_path: './swf/audio5js.swf'
    ready: -> promise.resolve this

  promise.promise()
