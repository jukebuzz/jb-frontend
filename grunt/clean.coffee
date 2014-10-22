module.exports =
  clean:
    dist:
      options:
        force: true
      files: [
        dot: true
        src: [
          "<%= yeoman.tmpPath %>",
          "<%= yeoman.dist %>/*",
          "!<%= yeoman.dist %>/.git*"
        ]
      ]
    server: "<%= yeoman.tmpPath %>"
