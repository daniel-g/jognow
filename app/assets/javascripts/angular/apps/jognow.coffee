angular.module('Jognow', ['Timesheet', 'Login'])
.config(['$routeProvider', ($routeProvider)->
  $routeProvider.
    when('/', {
      controller: 'AppController'
      redirectTo: '/timesheet'
    }).
    when('/login', {
      templateUrl: 'users/sign_in'
    }).
    when('/register', {
      templateUrl: 'users/sign_up'
    }).
    when('/timesheet', {
      templateUrl: 'time_entries/'
    }).
    when('/reports', {
      templateUrl: 'reports/'
    })
])
