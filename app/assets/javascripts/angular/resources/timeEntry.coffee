window.app.service('TimeEntry', ['$resource', ($resource)->
  $resource('/time_entries/:id.json', {}, {
    'query': {
      method:'GET',
      isArray:true,
      transformResponse: (data, headersGetter)->
        data = JSON.parse(data)
        for timeEntry in data
          timeEntry.date = new Date(timeEntry.date)
        data
    }
  })
])
