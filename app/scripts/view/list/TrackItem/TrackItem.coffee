define (require, exports, module)->
  _List = require "../_List"
  TrackItem = _List.extend
    template: "#TrackItem"
    className: "track_item"

    ui:
      number: '[data-js-number]'
      artist: '[data-js-artist]'
      title: '[data-js-title]'
      duration: '[data-js-duration]'
      artwork: '[data-js-artwork]'
      scLogo: '[data-js-sc]'

    bindings:
      ':el': 'classes: {first: isFirst}'
      '@ui.number': 'text: number'
      '@ui.artist': 'text: artist'
      '@ui.title': 'text: title'
      '@ui.duration': 'text: durationString'
      '@ui.scLogo': 'attr: {href: permalink_url}'
      '@ui.artwork': 'attr:{src: artwork_url}'

    computeds:
      isFirst:
        deps: ['number']
        get: (number)-> +number is 1

    initialize: ->

