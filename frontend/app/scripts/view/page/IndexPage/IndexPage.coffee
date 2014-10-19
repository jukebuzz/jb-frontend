define (require, exports, module)->
  _Page = require "../_Page"
  AuthModal = require "view/modal/AuthModal/AuthModal"
  common = require "common"

  IndexPage = _Page.extend
    template:"#IndexPage"
    className:"index_page"

    ui:
      signInLink: '[data-js-sign-in]'
      enterLink: '[data-js-enter]'

    bindings:
      '@ui.signInLink': 'classes: {hide: (uid)}'
      '@ui.enterLink': 'classes: {hide: not(uid)}'

    events:
      'click @ui.signInLink': 'onClickSignIn'

    initialize: ->
      @model = common.user

    onClickSignIn:(e)->
      e.preventDefault()
      e.stopPropagation()
      href = $(e.target).attr("href")

      @openWindow href, 660, 370
      window.callAuthSuccess = =>
        @unbindWindowCallback()
        common.user.refresh()
        common.router.navigate "#!/rooms", {trigger: true}

    openWindow:(href, width,height)->
      top = (screen.height - height)/2
      left = (screen.width - width)/2
      params = "top=#{top},left=#{left},height=#{height},width=#{width},resizable=no"
      win = window.open href, "auth"
      win.focus()

    unbindWindowCallback:->
      window.callAuthSuccess = null
      window.callAuthFail = null

