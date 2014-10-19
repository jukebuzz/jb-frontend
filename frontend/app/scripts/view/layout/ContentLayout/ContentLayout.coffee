define (require, exports, module)->
  Layout = require "../_Layout"

  ContentLayout = Layout.extend
    initialize:->
      if window.location.hash not in ["", "#"]
        ($ '.index_page').hide()

    render: ->
      $('index_page__button').removeClass 'hide'
