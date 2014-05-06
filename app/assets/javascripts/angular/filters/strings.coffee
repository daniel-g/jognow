window.app.filter('time', ['$filter', ($filter)->
  (seconds)->
    if seconds >= 60*60
      "#{ $filter('number')(seconds/(60*60), 2) } hr"
    else
      "#{ $filter('number')(seconds/60, 2) } min"
])
window.app.filter('humanizeConstant', ->
  (text)->
    if(text)
      string = text.split("_").join(" ").toLowerCase()
      string = string.charAt(0).toUpperCase() + string.slice(1)
      string
)
