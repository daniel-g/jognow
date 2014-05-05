angular.module('Login', ['General'])
.controller('SessionsController', ['$scope', 'Session', ($scope, Session)->
  $scope.create = ->
    $scope.submitted = true
    return if $scope.form.$invalid
    session = new Session({
      user: $scope.user
    })
    session.$signIn($scope.createSuccess, $scope.createError)

    $scope.createSuccess = (response, responseObj)->
      console.log response

    $scope.createError = (response)->
      console.log response
])
.controller('RegistrationsController', ['$scope', 'User', ($scope, User)->
  $scope.create = ->
    $scope.submitted = true
    return if $scope.form.$invalid
    user = new User({
      user: $scope.user
    })
    user.$save($scope.createSuccess, $scope.createError)

    $scope.createSuccess = (response, responseObj)->
      console.log response

    $scope.createError = (response)->
      console.log response
])
