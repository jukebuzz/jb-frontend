define ["//connect.soundcloud.com/sdk.js","preprocess"],(sc,preprocess)->
  SC.initialize
    client_id: preprocess.SC
    redirect_uri: "http://example.com/callback.html"
