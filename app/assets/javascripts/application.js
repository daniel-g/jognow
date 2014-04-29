//= require jquery
//= require bootstrap
//= require angular
//= require angular-route
//= require angular-resource
//= require angular-animate
//= require angular-strap

//= require_self
//= require_tree ./angular/controllers
//= require_tree ./angular/resources
//= require_tree ./angular/directives

angular.module('Jognow', [
  'ngResource', 'ngAnimate', 'ngRoute','mgcrea.ngStrap'
]).config(['$httpProvider', function($httpProvider){
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);


app = angular.module('Jognow');

var ready = function(){
  angular.bootstrap(angular.element("body"), ['Jognow']);
}

$(document).ready(ready);
