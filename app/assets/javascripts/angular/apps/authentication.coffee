angular.module('Authentication', [])
.controller('SessionsController', ['$scope', 'Session', 'UserService', '$alert', '$location', ($scope, Session, UserService, $alert, $location)->
  $scope.create = ->
    $scope.submitted = true
    return if $scope.form.$invalid
    session = new Session({
      user: $scope.user
    })
    session.$signIn($scope.createSuccess, $scope.createError)

  $scope.createSuccess = (response, responseObj)->
    UserService.isLoggedIn = true
    UserService.user = response
    $location.path('/timesheet')

  $scope.createError = (response)->
    $alert({title: 'Error:', content: 'Please try again.', placement: 'top', type: 'info', show: true})
])
.controller('RegistrationsController', ['$scope', 'User', 'UserService', '$alert', '$location', ($scope, User, UserService, $alert, $location)->
  $scope.create = ->
    $scope.submitted = true
    return if $scope.form.$invalid
    user = new User({
      user: $scope.user
    })
    user.$save($scope.createSuccess, $scope.createError)

  $scope.createSuccess = (response, responseObj)->
    UserService.isLoggedIn = true
    UserService.user = response
    $location.path('/timesheet')

  $scope.createError = (response)->
    $alert({title: 'Error:', content: 'Please try again.', placement: 'top', type: 'info', show: true})
])
