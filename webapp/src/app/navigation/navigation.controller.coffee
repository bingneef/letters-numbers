angular.module 'App'
  .controller 'NavigationController', ($rootScope, $scope, $state, $timeout, Authentication) ->
    'ngInject'

    $scope.overlay = false

    $scope.hideOverlay = ->
      $scope.overlay = false

    $scope.toggleOverlay = ->
      $scope.overlay = !$scope.overlay

    $scope.logoutUser = ->
      Authentication.clearAndLeave()


    return
