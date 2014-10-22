module.exports =
  app: "app"
  dist: "../public"
  tmpPath: ".tmp"
  scriptlang:"coffee" #js|coffee
  templatelang:"jade" #swig|jade

  open:
    server:
      host: "localhost:9001"
      path: "/"

  swig:
    params:{}

  copy:[
    'app/styles/fonts/fontawesome-webfont.eot': 'app/bower_components/font-awesome/fonts/fontawesome-webfont.eot'
    'app/styles/fonts/fontawesome-webfont.svg': 'app/bower_components/font-awesome/fonts/fontawesome-webfont.svg'
    'app/styles/fonts/fontawesome-webfont.ttf': 'app/bower_components/font-awesome/fonts/fontawesome-webfont.ttf'
    'app/styles/fonts/fontawesome-webfont.woff': 'app/bower_components/font-awesome/fonts/fontawesome-webfont.woff'

  #  expand: true
  #  cwd: "/bower_components/owl-carousel/owl-carousel/"
  #  src: "owl.carousel.css"
  #  dest: "/styles/vendor/owlcarousel/"
  #  rename: (dest, filename, orig)->
  #    dest + filename.replace( /([^\/]+)\.css$/, "_$1.scss")
  #,
  #  expand: true
  #  cwd: "/bower_components/owl-carousel/owl-carousel/"
  #  src: ["grabbing.png", "AjaxLoader.gif"]
  #  dest: "/images/vendor/owlcarousel/"
  ]
  copy_deps:[]
    #options:
    #  process: (content, srcpath)->
    #    #if /pen\.css$/.test srcpath
    #    #  content.replace "font/fontello", "font/fontello"
    #    #else
    #    content
    #files: []

  sprite:
    all:
      # не занимать путь `sprites`, туда генерируются спрайты
      path: "sprites"
      format: "png"
      # шаблон для генерации стилей, по умолчанию используется другой шаблон, генерирующий миксины
      template: "grunt/spritetemplates/class.scss.mustache"

  proxy:
    port: 9001
    default:"test"
    remotes:
      test:
        active: true
        host: "yandex.ru"
        port: 80
        https: false
      production:
        active: true
        host: "google.ru"
        port: 80
        https: false
    routers:
      test:
        "wiki/Main_Page$":
          host:"en.wikipedia.org"
          port:80
          https:false
      production:
        "wiki/Main_Page$":
          host:"en.wikipedia.org"
          port:80
          https:false
