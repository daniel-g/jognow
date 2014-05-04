window.app.service('Report', ['$resource', ($resource)->
  $resource('reports/:id.json', {}, {
    'timeEntries': {
      params: { id: 'time_entries'}
      method:'GET',
      transformResponse: (data, headersGetter)->
        data = JSON.parse(data)
        data.date = moment(data.date).toDate()
        data
    }
  })
])
