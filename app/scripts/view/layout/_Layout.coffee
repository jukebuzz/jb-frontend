define [
  'backbone'
  'underscore'
  'backbone-mixin'
  'epoxy'
],(Backbone, _, MixinBackbone)->

  Layout = MixinBackbone(Backbone.Epoxy.View).extend {}

