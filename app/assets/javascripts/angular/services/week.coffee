window.app.service('Week', ->
  class Week
    constructor: ->
      @days = [{
        name: 'Monday',
        year: 2014,
        month: 4,
        day: 29
      }, {
        name: 'Tuesday',
        year: 2014,
        month: 4,
        day: 29
      }, {
        name: 'Wednesday',
        year: 2014,
        month: 4,
        day: 29
      }, {
        name: 'Thursday',
        year: 2014,
        month: 4,
        day: 29
      }, {
        name: 'Friday',
        year: 2014,
        month: 4,
        day: 29
      }, {
        name: 'Saturday',
        year: 2014,
        month: 4,
        day: 29
      }, {
        name: 'Sunday',
        year: 2014,
        month: 4,
        day: 29
      }]

    goNextWeek: ->
      @days = [{
        name: 'Monday',
        year: 2014,
        month: 4,
        day: 30
      }, {
        name: 'Tuesday',
        year: 2014,
        month: 4,
        day: 30
      }, {
        name: 'Wednesday',
        year: 2014,
        month: 4,
        day: 30
      }, {
        name: 'Thursday',
        year: 2014,
        month: 4,
        day: 30
      }, {
        name: 'Friday',
        year: 2014,
        month: 4,
        day: 30
      }, {
        name: 'Saturday',
        year: 2014,
        month: 4,
        day: 30
      }, {
        name: 'Sunday',
        year: 2014,
        month: 4,
        day: 30
      }]
)