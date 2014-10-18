define (require, exports, module)->
  Layout = require "../_Layout"
  Backbone = require "backbone"
  common = require 'common'
  require 'epoxy'

  ViewModel = Backbone.Model.extend
    defaults:
      show: false

    showOn: ['rooms']

    initialize: ->
      @listenTo common.router, 'route', @onRoute

    onRoute: (route)-> @set {show:+(route in @showOn)}

  class NavigationLayout extends Layout
    bindings:
      ":el": "classes: {visible: show}"

    initialize:->
      @viewModel = new ViewModel
      super


