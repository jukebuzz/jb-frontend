define (require)->
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

    constructor: ( @audio = new Audio(), @numBands = 256, @smoothing = 0.3 ) ->

      # construct audio object
      if typeof @audio is 'string'

        src = @audio
        @audio = new Audio()
        @audio.controls = yes
        @audio.src = src

      # setup audio context and nodes
      @context = new AudioAnalyser.AudioContext()

      # createScriptProcessor so we can hook onto updates
      @jsNode = @context.createScriptProcessor 2048, 1, 1

      # smoothed analyser with n bins for frequency-domain analysis
      @analyser = @context.createAnalyser()
      @analyser.smoothingTimeConstant = @smoothing
      @analyser.fftSize = @numBands * 2

      # persistant bands array
      @bands = new Uint8Array @analyser.frequencyBinCount

      # circumvent http://crbug.com/112368
      @audio.addEventListener 'canplay', =>

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

