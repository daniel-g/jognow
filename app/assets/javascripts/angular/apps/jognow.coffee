angular.module('Jognow', ['General', 'Timesheet', 'Authentication'])
.config(['$routeProvider', ($routeProvider)->
  $routeProvider.
    when('/', {
      controller: 'AppController'
      redirectTo: '/timesheet'
    }).
    when('/login', {
      templateUrl: 'users/sign_in'
      auth: false
    }).
    when('/register', {
      templateUrl: 'users/sign_up'
      auth: false
    }).
    when('/timesheet', {
      templateUrl: 'time_entries/'
      auth: true
    }).
    when('/reports', {
      templateUrl: 'reports/'
      auth: true
    })
])
.run(['$rootScope', '$location', 'UserService', 'Session', ($rootScope, $location, UserService, Session)->
  $rootScope.$on("$routeChangeStart", (event, next, current)->
    return unless next.auth?
    if next.auth
      if !UserService.isLoggedIn
        session = new Session
        session.$signIn(
          (response, responseObj)->
            UserService.isLoggedIn = true
            UserService.user = response
            $location.path("/timesheet")
          ,
          (response)->
            $location.path("/login")
        )
    else
      if UserService.isLoggedIn
        $location.path("/timesheet")
  )
])
.service('UserService', ->
  {
    isLoggedIn: false
    user: null
  }
)
