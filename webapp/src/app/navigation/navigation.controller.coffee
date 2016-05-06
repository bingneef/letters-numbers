angular.module 'App'
  .controller 'NavigationController', ($rootScope, $scope, $state, $timeout, localStorageService) ->
    'ngInject'

    $scope.overlay = false

    $scope.hideOverlay = ->
      $scope.overlay = false

    $scope.toggleOverlay = ->
      $scope.overlay = !$scope.overlay

    $scope.logoutUser = ->
      $rootScope.credentials = null
      localStorageService.set('credentials', {})
      $state.go 'fs.login'


    return
