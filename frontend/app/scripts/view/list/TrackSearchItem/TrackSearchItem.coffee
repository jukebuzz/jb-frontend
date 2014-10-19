define (require, exports, module)->
  _List = require "../_List"
  TrackSearchItem = _List.extend
    template: "#TrackSearchItem"
    className: "tracksearch_item"
    ui:
      number: '[data-js-number]'
      artist: '[data-js-artist]'
      title: '[data-js-title]'
      duration: '[data-js-duration]'
      artwork: '[data-js-artwork]'

    bindings:
      ':el': 'classes: {active:active}'
      '@ui.artist': 'text: artist'
      '@ui.title': 'text: title'
      '@ui.duration': 'text: durationString'
      '@ui.artwork': 'attr:{src: artwork_url}'

    events:
      'mouseenter': 'onHover'

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
