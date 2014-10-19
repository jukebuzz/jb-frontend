define (require)->
  Sketch = require 'sketch'
  AudioAnalyser = require 'utils/analyser'
  Particle = require 'utils/particle'

  NUM_PARTICLES = 150
  NUM_BANDS = 128
  SMOOTHING = 0.5

  SCALE = MIN: 5.0,  MAX: 80.0
  SPEED = MIN: 0.2,   MAX: 1.0
  ALPHA = MIN: 0.8,   MAX: 0.9
  SPIN  = MIN: 0.001, MAX: 0.005
  SIZE  = MIN: 0.5,   MAX: 1.25

  COLORS = [
    '#69D2E7'
    '#1B676B'
    '#BEF202'
    '#EBE54D'
    '#00CDAC'
    '#1693A5'
    '#F9D423'
    '#FF4E50'
    '#E7204E'
    '#0CCABA'
    '#FF006F'
  ]

  class SketchWrap
    constructor: (el, MP3_PATH)->
      @ctx = Sketch.create
        container: el
        particles: []
        setup: ->
        # generate some particles
          for i in [0..NUM_PARTICLES-1] by 1

            x = random @width
            y = random @height * 2

            particle = new Particle x, y
            particle.energy = random particle.band / 256

            @particles.push particle

          if AudioAnalyser.enabled

            try

              # setup the audio analyser
              analyser = new AudioAnalyser MP3_PATH, NUM_BANDS, SMOOTHING

              # update particles based on fft transformed audio frequencies
              analyser.onUpdate = ( bands ) => particle.energy = bands[ particle.band ] / 256 for particle in @particles

              # start as soon as the audio is buffered

              # show audio controls
              document.body.appendChild analyser.audio

              intro = document.getElementById 'intro'
              intro.style.display = 'none'

              # bug in Safari 6 when using getByteFrequencyData with MediaElementAudioSource
              # @see http://goo.gl/6WLx1
              if /Safari/.test( navigator.userAgent ) and not /Chrome/.test( navigator.userAgent )

                warning = document.getElementById 'warning2'
                warning.style.display = 'block'

            catch error

          else

            # Web Audio API not detected
            warning = document.getElementById 'warning1'
            warning.style.display = 'block'

        draw: ->

          @globalCompositeOperation = 'lighter'

          for particle in @particles

            # recycle particles
            if particle.y < -particle.size * particle.level * particle.scale * 2

              particle.reset()
              particle.x = random @width
              particle.y = @height + particle.size * particle.scale * particle.level

            particle.move()
            particle.draw @

    kill: -> @ctx.destroy()
