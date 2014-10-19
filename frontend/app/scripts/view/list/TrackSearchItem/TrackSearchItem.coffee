define (require, exports, module)->
  _List = require "../_List"
  common = require 'common'
  require 'bootstrap'
  TrackSearchItem = _List.extend
    template: "#TrackSearchItem"
    className: "tracksearch_item"
    ui:
      number: '[data-js-number]'
      artist: '[data-js-artist]'
      title: '[data-js-title]'
      duration: '[data-js-duration]'
      artwork: '[data-js-artwork]'
      btnAdd: '[data-js-add]'

    bindings:
      ':el': 'classes: {active:active, added: added}'
      '@ui.artist': 'text: artist'
      '@ui.title': 'text: title'
      '@ui.duration': 'text: durationString'
      '@ui.artwork': 'attr:{src: artwork_url}'

    events:
      'mouseenter': 'onHover'
      'click @ui.btnAdd': 'onClickAdd'

    delayPlayTime: 1000
    delayStopTime: 1000

    onHover: ->
      _.delay =>
        @model.set {active:true} if @$el.is ':hover'
        @checkHover()
      , @delayPlayTime

    checkHover: ->
      _.delay =>
        if @$el.is ':hover'
          @checkHover()
        else
          @model.set {active:false}
      , @delayStopTime

    onClickAdd: ->
      id = @model.get 'id'
      room_id = common.user.get 'active_room_id'
      common.api.post_playlist_id_items(room_id, id).done (data)=>
        common.user.refresh()
        common.trackCollection.setData data
        @model.set {added: true}

        # play sound

