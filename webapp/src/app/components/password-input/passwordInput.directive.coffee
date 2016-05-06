angular.module 'App'
  .directive 'passwordInput', ->
    scope: false,
    templateUrl: 'app/components/password-input/password-input.html'
    link: ($scope, elem, attr) ->

