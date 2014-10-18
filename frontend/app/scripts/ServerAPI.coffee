define ["sp-utils-serverclient"],(ServerClient)->
  class ServerAPI extends ServerClient
    initialize:->

    _isServer:-> false #can using stubs

    get_data:->
      @get {
        url:"/api"
        stub:(async)->
          async.resolve "stub data"
      }

    get_current_user: ->
      @get {
        url: "/api/users/current"
        xstub:(async)-> async.resolve {
            name: "NotMaxim Koretskiy"
            email: "mr.green.tv@gmail.com"
            avatar: "https://avatars2.githubusercontent.com/u/2323027?v=2&s=200"
            coins: 200
          }
      }

    delete_auth: ->
      @ajax {
        type: "DELETE"
        url: "/api/auth"
      }

    get_rooms: ->
      @get {
        url:"/api/rooms"
        stub:(async)-> async.resolve []
      }
