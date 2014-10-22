define [
  "backbone"
  "sp-utils-middleware"
  "common"
  "view/page"
  "view/modal"
],(
  Backbone
  Middleware
  common
  Page
  Modal
)->

  showPage=(View,options={},callback)->
    common.app.content.show View, options, callback

  class MiddlewareRouter extends Middleware
    auth:(async,args)->
      async.resolve "auth"

  middleware = new MiddlewareRouter

  Router = Backbone.Router.extend

    routes:
      "":"index"
      "!/rooms(/:id)": "rooms"
      "!/roomadd/:token": "roomAdd"
      "!/404": "error404"
      "*default":"default_router"

    index: middleware.wrap ->
      view = showPage Page.IndexPage

    rooms: middleware.wrap (id)->
      auto_id = common.user.get 'active_room_id' unless id?
      if auto_id?
        @navigate "!/rooms/#{auto_id}", {trigger: true}
        return
      view = showPage Page.MainPage
      view.setRoom id if id?

    roomAdd: middleware.wrap (token)->
      common.api.post_rooms_join(token)
        .done (data)->
          Backbone.trigger "rooms:needUpdate"
          common.router.navigate "!/rooms/#{data.id}", {trigger:true}
        .fail -> common.router.navigate "#", {trigger: true}

    error404: middleware.wrap ->
      showPage Page.Error404Page

    default_router:->
      @navigate "!/404", {trigger:true,replace:true}
