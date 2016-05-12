angular.module 'App'
  .controller 'LettersNumbersSlaveController', ($rootScope, $scope, $state, $window, $timeout, $interval, SocketService, SweetAlert, socketCredentials) ->
    'ngInject'

    return unless $rootScope.shallowCredentials
    room = "#{$rootScope.shallowCredentials.email}::#{$rootScope.shallowCredentials.pin}"
    SocketService.initiate(socketCredentials, room)

    $scope.status = {}
    activeLevel = 'letters-numbers'

    $scope.tiles = [
      {
        key: 1
        value: 1597
        letter: 'B'
      }
      {
        key: 2
        value: 2584
        letter: 'N'
      }
      {
        key: 3
        value: 4181
        letter: 'I'
      }
      {
        key: 4
        value: 6765
        letter: 'O'
      }
      {
        key: 5
        value: 13
        letter: 'K'
      }
      {
        key: 6
        value: 21
        letter: 'F'
      }
      {
        key: 7
        value: 34
        letter: 'R'
      }
      {
        key: 8
        value: 55
        letter: 'A'
      }
      {
        key: 9
        value: 8
        letter: 'B'
      }
      {
        key: 10
        value: 1
        letter: 'S'
      }
      {
        key: 11
        value: 1
        letter: 'O'
      }
      {
        key: 12
        value: 89
        letter: 'U'
      }
      {
        key: 13
        value: 5
        letter: 'I'
      }
      {
        key: 14
        value: 3
        letter: 'U'
      }
      {
        key: 15
        value: 2
        letter: 'T'
      }
      {
        key: 16
        value: 144
        letter: 'C'
      }
      {
        key: 17
        value: 987
        letter: 'C'
      }
      {
        key: 18
        value: 610
        letter: 'L'
      }
      {
        key: 19
        value: 377
        letter: 'I'
      }
      {
        key: 20
        value: 233
        letter: 'A'
      }
      {
        key: 21
        value: 46368
        letter: 'A'
      }
      {
        key: 22
        value: 28657
        letter: 'I'
      }
      {
        key: 23
        value: 17711
        letter: 'E'
      }
      {
        key: 24
        value: 10946
        letter: 'A'
      }
    ]

    $rootScope.$on 'socketTransmit', (event, data) ->
      return unless data.level == activeLevel
      switch data.kind
        when 'status'
          paintBackground(data.value)

    $scope.tileClick = (tile) ->
      tile.selected = !tile.selected
      payload =
        level: activeLevel
        destination: 'host'
        kind: 'tileStatus'
        tiles: $scope.tiles

      SocketService.socketTransmit payload
    return
