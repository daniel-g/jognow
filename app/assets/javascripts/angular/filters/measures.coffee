window.app.filter('time', ['$filter', ($filter)->
  (seconds)->
    if seconds >= 60*60
      "#{ $filter('number')(seconds/(60*60), 2) } hr"
    else
      "#{ $filter('number')(seconds/60, 2) } min"
])
window.app.filter('distance', ['$filter', ($filter)->
  (meters)->
    if meters >= 1000
      "#{ $filter('number')(meters/1000, 2) } km"
    else
      "#{ $filter('number')(meters, 2) } m"
])
window.app.filter('speedToKmH', ['$filter', ($filter)->
  (mS)->
    mS * 3.6
])
