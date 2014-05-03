angular.module('Jognow', ['General'])
.config(['$routeProvider', ($routeProvider)->
  $routeProvider.
    when('/', {
      redirectTo: '/timesheet'
    }).
    when('/timesheet/:year?/:month?/:day?', {
      templateUrl: 'time_entries/show'
    }).
    when('/reports', {
      templateUrl: 'reports/'
    })
])
.service('MeasuresHelpers', ->
  {
    strToMeters: (string)->
      return -1 unless string?
      n = parseFloat(string)
      return -1 if n == NaN
      if string.indexOf('km') > 0
        n*1000
      else
        n

    strToSeconds: (string)->
      return -1 unless string?
      n = parseFloat(string)
      return -1 if n == NaN
      if /h|hrs?|hours?$/.test(string)
        n*60*60
      else
        n*60
  }
)
.service('TimeEntryPresenter', ['MeasuresHelpers', (MeasuresHelpers)->
  class TimeEntryPresenter
    constructor: (timeEntry)->
      @timeEntry = timeEntry

    present: ->
      {
        time: MeasuresHelpers.strToSeconds(@timeEntry.time)
        distance: MeasuresHelpers.strToMeters(@timeEntry.distance)
        date: @timeEntry.date
      }
])
.controller('HeaderController', ['$scope', '$location', ($scope, $location)->
  $scope.isActive = (route)->
    route == $location.path()
])
.controller('TimeEntriesController', [
  '$scope', 'TimeEntry', 'TimeEntryPresenter', ($scope, TimeEntry, TimeEntryPresenter)->
    $scope.timeEntries = TimeEntry.query()
    $scope.timeEntry = {
      date: (new Date)
    }
    $scope.create = ->
      $scope.submitted = true
      return if $scope.form.$invalid
      TimeEntry.save({
        time_entry: (new TimeEntryPresenter($scope.timeEntry)).present()
      }, $scope.createSuccess, $scope.createError)

    $scope.createSuccess = (response, responseObj)->
      $scope.timeEntries.push response
      $scope.resetTimeEntry()

    $scope.createError = (response)->
      console.log response

    $scope.resetTimeEntry = ->
      $scope.submitted = false
      $scope.timeEntry = {
        date: (new Date)
      }
      $scope.form.$setPristine()
])
