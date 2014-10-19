define (require, exports, module)->
  _Modal = require "../_Modal"
  GithubModal = _Modal.extend
    template: "#GithubModal"
    className: "github_modal"

    ui:
      name: '[data-js-name]'
      link: '[data-js-link]'

    bindings:
      '@ui.name': 'text: name'
      '@ui.link': 'value: github_link'

    events:
      'click @ui.link': 'onClickLink'

    onClickLink: ->
      @ui.link.select()

    # initialize: ->
    #  _Modal::initialize.apply this, arguments
    #  You code here
