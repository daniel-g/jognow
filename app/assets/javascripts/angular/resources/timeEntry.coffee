window.app.service('TimeEntry', ['$resource', ($resource)->
  $resource('/time_entries/:id.json', {}, {
    'query': {
      method:'GET',
      isArray:true,
      transformResponse: (data, headersGetter)->
        data = JSON.parse(data)
        for timeEntry in data
          timeEntry.date = moment(timeEntry.date).toDate()
        data
    }
    'save': {
      method:'POST',
      transformResponse: (data, headersGetter)->
        data = JSON.parse(data)
        data.date = moment(data.date).toDate()
        data
    }
  })
])
