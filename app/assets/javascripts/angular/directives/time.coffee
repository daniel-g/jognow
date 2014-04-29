window.TIME_REGEXP = /^\d+(\.\d+)?\s*(h|hrs?|m|mins?|hours?|minutes?)$/
window.app.directive('time', ->
  require: 'ngModel',
  link: ($scope, $elm, $attrs, $ctrl)->
    $ctrl.$parsers.unshift (viewValue)->
      if TIME_REGEXP.test(viewValue)
        $ctrl.$setValidity('time', true)
      else
        $ctrl.$setValidity('time', false)
      viewValue
)
