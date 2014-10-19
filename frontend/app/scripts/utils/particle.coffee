define (require)->

  NUM_PARTICLES = 150
  NUM_BANDS = 128
  SMOOTHING = 0.5
  MP3_PATH = 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1715/the_xx_-_intro.mp3'

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

  class Particle

    constructor: ( @x = 0, @y = 0 ) ->

      @reset()

    reset: ->

      @level = 1 + floor random 4
      @scale = random SCALE.MIN, SCALE.MAX
      @alpha = random ALPHA.MIN, ALPHA.MAX
      @speed = random SPEED.MIN, SPEED.MAX
      @color = random COLORS
      @size = random SIZE.MIN, SIZE.MAX
      @spin = random SPIN.MAX, SPIN.MAX
      @band = floor random NUM_BANDS

      if random() < 0.5 then @spin = -@spin

      @smoothedScale = 0.0
      @smoothedAlpha = 0.0
      @decayScale = 0.0
      @decayAlpha = 0.0
      @rotation = random TWO_PI
      @energy = 0.0

    move: ->

      @rotation += @spin
      @y -= @speed * @level

    draw: ( ctx ) ->

      power = exp @energy
      scale = @scale * power
      alpha = @alpha * @energy * 1.5

      @decayScale = max @decayScale, scale
      @decayAlpha = max @decayAlpha, alpha

      @smoothedScale += ( @decayScale - @smoothedScale ) * 0.3
      @smoothedAlpha += ( @decayAlpha - @smoothedAlpha ) * 0.3

      @decayScale *= 0.985
      @decayAlpha *= 0.975

      ctx.save()
      ctx.beginPath()
      ctx.translate @x + cos( @rotation * @speed ) * 250, @y
      ctx.rotate @rotation
      ctx.scale @smoothedScale * @level, @smoothedScale * @level
      ctx.moveTo @size * 0.5, 0
      ctx.lineTo @size * -0.5, 0
      ctx.lineWidth = 1
      ctx.lineCap = 'round'
      ctx.globalAlpha = @smoothedAlpha / @level
      ctx.strokeStyle = @color
      ctx.stroke()
      ctx.restore()

