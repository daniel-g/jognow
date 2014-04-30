#= require jquery
#= require bootstrap
#= require angular
#= require angular-route
#= require angular-resource
#= require angular-animate
#= require angular-strap

#= require_self
#= require_tree ./angular/services
#= require_tree ./angular/resources
#= require_tree ./angular/directives
#= require angular/apps/jognow

window.app = angular.module('General', [
  'ngResource', 'ngAnimate', 'ngRoute', 'mgcrea.ngStrap'
]).config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
])