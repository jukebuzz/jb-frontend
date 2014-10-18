define (require, exports, module)->
  Layout = require "../_Layout"
  Backbone = require "backbone"
  CurrentUserWidget = require "view/widget/CurrentUserWidget/CurrentUserWidget"
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

    regions:
      user:
        el: '[data-view-user]'
        view: CurrentUserWidget



    bindings:
      ":el": "classes: {visible: show}"

    initialize:->
      @viewModel = new ViewModel
      super


