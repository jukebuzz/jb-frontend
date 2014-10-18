define (require, exports, module)->
  _Page = require "../_Page"
  MainPage = _Page.extend
    template: "#MainPage"
    className: "main_page"
