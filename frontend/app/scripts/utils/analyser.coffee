define (require)->
  _ = require "underscore"
  NUM_PARTICLES = 150
  NUM_BANDS = 128
  SMOOTHING = 0.5

  SCALE = MIN: 5.0,  MAX: 80.0
  SPEED = MIN: 0.2,   MAX: 1.0
  ALPHA = MIN: 0.8,   MAX: 0.9
  SPIN  = MIN: 0.001, MAX: 0.005
  SIZE  = MIN: 0.5,   MAX: 1.25

  class AudioAnalyser

    @AudioContext: self.AudioContext or self.webkitAudioContext
    @enabled: @AudioContext?

    constructor: (@numBands = 256, @smoothing = 0.3 ) ->
      @enabled = AudioAnalyser.enabled
      @setupAnalyser()
      @setupAudio()

    setupAnalyser: ->
      return unless AudioAnalyser.enabled
      @context = new AudioAnalyser.AudioContext()
      # createScriptProcessor so we can hook onto updates
      @jsNode = @context.createScriptProcessor 2048, 1, 1
      # smoothed analyser with n bins for frequency-domain analysis
      @analyser = @context.createAnalyser()
      @analyser.smoothingTimeConstant = @smoothing
      @analyser.fftSize = @numBands * 2

      # persistant bands array
      @bands = new Uint8Array @analyser.frequencyBinCount

    setupAudio: ->
      @audio = new Audio
      return unless AudioAnalyser.enabled
      @audio.addEventListener 'canplay', => @onAudioCanplay()

    setSrc: (src)-> @audio.src

    getAudio: -> @audio

    onAudioCanplay: _.memoize ->
      # media source
      @source = @context.createMediaElementSource @audio
      # wire up nodes
      @source.connect @analyser
      @analyser.connect @jsNode
      @jsNode.connect @context.destination
      @source.connect @context.destination

      # update each time the JavaScriptNode is called
      @jsNode.onaudioprocess = =>

        # retreive the data from the first channel
        @analyser.getByteFrequencyData @bands

        # fire callback
        @onUpdate? @bands if not @audio.paused

    start: ->
      @audio.play()

    stop: ->
      @audio.pause()

