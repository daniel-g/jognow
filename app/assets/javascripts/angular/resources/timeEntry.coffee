window.app.service('TimeEntry', ['$resource', ($resource)->
  $resource('/time_entries/:id.json')
])
