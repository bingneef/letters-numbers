angular.module 'App'
  .controller 'LettersNumbersController', ($rootScope, $scope, $state, $window, $timeout, $interval, SocketService, SweetAlert, socketCredentials) ->
    'ngInject'

    return unless $rootScope.shallowCredentials
    room = "#{$rootScope.shallowCredentials.email}::#{$rootScope.shallowCredentials.pin}"
    SocketService.initiate(socketCredentials, room)

    $scope.status = {}
    activeLevel = 'letters-numbers'
    $scope.answerCode = 'ef15d8edd00a6960c9c16937cbf14212'
    $scope.correctTiles = false
    $scope.userInputCode = ''

    $scope.$watch 'userInputCode', ->
      unless $scope.correctTiles
        $scope.codeStatus = ''
        return

      if $scope.userInputCode.length == 0
        $scope.codeStatus = ''
      else if angular.equals(md5($scope.userInputCode.toLowerCase().replace(/ /g,'')), $scope.answerCode)
        $scope.codeStatus = 'success'
      else
        $scope.codeStatus = 'error'

    $scope.answerTotal =
      sum: 10946
      count: 9

    $rootScope.$on 'socketTransmit', (event, data) ->
      return unless data.level == activeLevel
      switch data.kind
        when 'tileStatus'
          $scope.tiles = data.tiles
          $scope.$apply()

    $scope.$watch 'tiles', ->
      $scope.tilesCount = 0
      $scope.tilesSum = 0
      angular.forEach $scope.tiles, (tile) ->
        if tile.selected
          $scope.tilesCount += 1
          $scope.tilesSum += tile.value

      if $scope.tilesSum == $scope.answerTotal.sum && $scope.tilesCount == $scope.answerTotal.count
        $scope.correctTiles = true
      else
        $scope.correctTiles = false



    return

