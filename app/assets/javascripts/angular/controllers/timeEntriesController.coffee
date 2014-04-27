window.app.controller('timeEntriesController', [
  '$scope', 'TimeEntry', ($scope, TimeEntry)->
    $scope.create = ->
      TimeEntry.save({
        time_entry: $scope.time_entry
      }, $scope.createSuccess, $scope.createError)

    $scope.createSuccess = (xhrResponse, response)->
      console.log response

    $scope.createError = (response)->
      console.log response
])
