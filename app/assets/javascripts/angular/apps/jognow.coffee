angular.module('Jognow', ['General', 'Timesheet', 'Authentication'])
.config(['$httpProvider', ($httpProvider)->
  $httpProvider.interceptors.push([
    '$injector', ($injector)->
      return $injector.get('AuthInterceptor')
  ])
])
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
.factory('AuthInterceptor', ['UserService', '$location', '$q', (UserService, $location, $q)->
  return {
    responseError: (response)->
      console.log [401, 403, 419, 440].indexOf(response.status) != -1
      if [401, 403, 419, 440].indexOf(response.status) != -1
        UserService.isLoggedIn = false
        UserService.user = null
        $location.path('/login')
      return $q.reject(response)
  }
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
