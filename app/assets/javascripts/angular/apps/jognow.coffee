angular.module('Jognow', ['General'])
.controller('timeEntriesController', [
  '$scope', 'TimeEntry', ($scope, TimeEntry)->
    $scope.timeEntries = TimeEntry.query()
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
])
