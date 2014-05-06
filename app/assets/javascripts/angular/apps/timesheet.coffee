angular.module('Timesheet', [])
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
.controller('HeaderController', ['$scope', '$location', 'UserService', 'Session', ($scope, $location, UserService, Session)->
  $scope.isActive = (route)->
    route == $location.path()

  $scope.isUserLoggedIn = ->
    UserService.isLoggedIn

  $scope.username = ->
    if UserService.user?.first_name? or UserService.user?.last_name?
      [UserService.user?.first_name, UserService.user?.last_name].join(' ')
    else
      UserService.user?.email

  $scope.signOut = ->
    session = new Session
    session.$signOut(
      (response, responseObj)->
        UserService.isLoggedIn = false
        UserService.user = null
        $location.path('/login')
    )
])
.controller('TimeEntriesController', ['$scope', 'TimeEntry', 'TimeEntryPresenter', '$location', ($scope, TimeEntry, TimeEntryPresenter, $location)->
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
  $scope.search = {
    from: moment().startOf('week').toDate(),
    to: moment().endOf('week').toDate()
  }

  $scope.query = ->
    $scope.report = Report.timeEntries($scope.search)
  $scope.query()

  $scope.goToLastWeek = ->
    newFrom = moment($scope.search.from).subtract('w', 1).toDate()
    newTo = moment($scope.search.to).subtract('w', 1).toDate()
    $scope.search = {
      from: newFrom
      to: newTo
    }
    $scope.query()

  $scope.goToNextWeek = ->
    newFrom = moment($scope.search.from).add('w', 1).toDate()
    newTo = moment($scope.search.to).add('w', 1).toDate()
    $scope.search = {
      from: newFrom
      to: newTo
    }
    $scope.query()
])
