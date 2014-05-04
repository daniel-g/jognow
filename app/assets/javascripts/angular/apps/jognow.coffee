angular.module('Jognow', ['General'])
.config(['$routeProvider', ($routeProvider)->
  $routeProvider.
    when('/', {
      redirectTo: '/timesheet'
    }).
    when('/timesheet', {
      templateUrl: 'time_entries/'
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
  '$scope', 'TimeEntry', 'TimeEntryPresenter', '$location', ($scope, TimeEntry, TimeEntryPresenter, $location)->
    $scope.timeEntries = TimeEntry.query($location.$$search)
    today = new Date
    today.setHours(0,0,0,0)
    $scope.timeEntry = {
      date: today
    }

    $scope.create = ->
      $scope.submitted = true
      return if $scope.form.$invalid
      TimeEntry.save({
        time_entry: (new TimeEntryPresenter($scope.timeEntry)).present()
      }, $scope.createSuccess, $scope.createError)

    $scope.createSuccess = (response, responseObj)->
      response.date = new Date(response.date)
      if $scope.isWithinSearch(response)
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

    $scope.$watch('search.from', (newVal, oldVal)->
      return unless newVal?
      return if $scope.searchForm.from.$invalid
      $scope.timeEntries = TimeEntry.query($scope.search)
    )

    $scope.$watch('search.to', (newVal, oldVal)->
      return unless newVal?
      return if $scope.searchForm.to.$invalid
      $scope.timeEntries = TimeEntry.query($scope.search)
    )

    $scope.isWithinSearch = (timeEntry)->
      return false if $scope.search?.from? && timeEntry.date < $scope.search.from
      return false if $scope.search?.to? && timeEntry.date > $scope.search.to
      true
])
.controller('ReportsController', ['$scope', 'Report', ($scope, Report)->
  $scope.report = Report.timeEntries()
])
