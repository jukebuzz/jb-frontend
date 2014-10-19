define (require, exports, module)->
  Backbone = require "backbone"
  require "epoxy"

  TrackModel = Backbone.Epoxy.Model.extend

    defaults:
      artist: ""
      title: ""
      artwork_url: ""
      duration: 0
      soundcloud_id: ""
      stream_url: ""
      number: 0
      active: false
      added: false

    computeds:
      durationString:
        deps: ['duration']
        get: (duration)->
          duration /= 1000
          mm = Math.floor duration / 60
          ss = Math.floor duration % 60
          ss = "0" + ss if (""+ss).length is 1
          "#{mm}:#{ss}"

    parse:(r)->
      if r.user?
        r.artist = r.user.username
      r
