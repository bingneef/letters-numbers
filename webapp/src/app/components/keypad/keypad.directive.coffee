angular.module 'App'
  .directive 'keypad', ->
    scope: false,
    templateUrl: 'app/components/keypad/keypad.html'
    link: ($scope, elem, attr) ->

