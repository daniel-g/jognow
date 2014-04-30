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
.controller('timeEntriesController', [
  '$scope', 'TimeEntry', 'Week', ($scope, TimeEntry, Week)->
    $scope.timeEntries = TimeEntry.query()
    $scope.week = new Week
    $scope.create = ->
      $scope.submitted = true
      return if $scope.form.$invalid
      TimeEntry.save({
        time_entry: $scope.timeEntry
      }, $scope.createSuccess, $scope.createError)

    $scope.createSuccess = (response, responseObj)->
      $scope.timeEntries.push response
      $scope.resetTimeEntry()

    $scope.createError = (response)->
      console.log response

    $scope.resetTimeEntry = ->
      $scope.timeEntry = {}
      $scope.form.setPristine()

    $scope.goNextWeek = ->
      $scope.week.goNextWeek()

    $scope.goLastWeek = ->
      $scope.week.goLastWeek()
])
