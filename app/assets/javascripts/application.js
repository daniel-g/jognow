//= require jquery
//= require bootstrap
//= require angular
//= require angular-route
//= require angular-resource
//= require angular-animate
//= require angular-strap

//= require_self
//= require_tree ./angular/controllers

angular.module('Jognow', [
  'ngResource', 'ngAnimate', 'ngRoute','mgcrea.ngStrap'
]);
app = angular.module('Jognow');

var ready = function(){
  angular.bootstrap(angular.element("body"), ['Jognow']);
}

$(document).ready(ready);
