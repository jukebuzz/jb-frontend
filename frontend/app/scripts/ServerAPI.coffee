define ["sp-utils-serverclient","cookies"],(ServerClient, cookie)->

  class ServerClientPatched extends ServerClient
    _ajax: (options, async)->
      unless options.type is 'GET'
        options.headers = {
          'X-CSRF-Token': cookie.get('CSRF-Token')
        }
      super options, async


  class ServerAPI extends ServerClientPatched
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
        stub:(async)-> async.resolve [
          id: 2
          name: 'Dong Bobka'
          owner_id: '1'
          join_token: 'sasaSAsaSAsaDDDSDASDASDASDASD'
        ,
          id: 5
          name: 'Dong Bobka 1'
          owner_id: '31'
          join_token: 'sasaSAsaSAsaDDDSDASDASDASDASD'
        ,
          id: 7
          name: 'Bobka Dong'
          owner_id: '34'
          join_token: 'sasaSAsaSAsaDDDSDASDASDASDASD'
        ]
      }
