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
        stub:(async)-> async.resolve {
            name: "Maxim Koretskiy"
            email: "mr.green.tv@gmail.com"
            avatar: "https://avatars2.githubusercontent.com/u/2323027?v=2&s=200"
            coins: 200
          }
      }

    get_rooms: ->
      @get {
        url:"/api/rooms"
        stub:(async)-> async.resolve []
      }
