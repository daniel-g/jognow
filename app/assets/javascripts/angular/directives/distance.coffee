window.DISTANCE_REGEXP = /^\d+(\.\d+)?\s*(km|m)$/
window.app.directive('distance', ->
  require: 'ngModel',
  link: ($scope, $elm, $attrs, $ctrl)->
    $ctrl.$parsers.unshift (viewValue)->
      if DISTANCE_REGEXP.test(viewValue)
        $ctrl.$setValidity('distance', true)
      else
        $ctrl.$setValidity('distance', false)
      viewValue
)
