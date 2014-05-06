angular.module('Authentication', [])
.controller('SessionsController', ['$scope', 'Session', 'UserService', '$location', ($scope, Session, UserService, $location)->
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
    $scope.errors = true
])
.controller('RegistrationsController', ['$scope', 'User', 'UserService', '$location', ($scope, User, UserService, $location)->
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
    $scope.errors = response.data.errors
])
