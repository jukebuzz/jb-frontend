window.PREPROCESS = {}

# DEBUG PREPROCESS
###
// @ifdef DEBUG
###
window.PREPROCESS = {
  mode: "debug"
  GA: "UA-XXXXX-X"
  SC: "e90b73852966e0f8a83b4c4e39d90ab5"
  social:
    fb: appID: 0
    vk: appID: 0
    ok:
      appID: 0
      appKey: "CBAHGDCOABABABABA"
}
###
// @endif
###


# DIST PREPROCESS
###
// @ifdef DIST
###
window.PREPROCESS = {
  mode: "testing"
  GA: "UA-55892788-1"
  SC: "e90b73852966e0f8a83b4c4e39d90ab5"
  social:
    fb: appID: 0
    vk: appID: 0
    ok:
      appID: 0
      appKey: "CBAHGDCOABABABABA"
}
###
// @endif
###


# PROD PREPROCESS
###
// @ifdef PROD
###
window.PREPROCESS = {
  mode: "production"
  GA: "UA-55892788-1"
  SC: "e90b73852966e0f8a83b4c4e39d90ab5"
  social:
    fb: appID: 0
    vk: appID: 0
    ok:
      appID: 0
      appKey: "CBAHGDCOABABABABA"
}
###
// @endif
###

