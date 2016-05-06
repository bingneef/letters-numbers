angular.module 'App'
  .service 'SocketService', ($rootScope, socketUrl, localStorageService) ->
    'ngInject'

    socket: io.connect(socketUrl)
    initiate: (credentials, room) ->
      this.socket.on 'socketTransmit', (data) ->
        if angular.equals data.destination, $rootScope.socketRole
          $rootScope.$broadcast 'socketTransmit', data

      # Some error handling
      this.socket.on 'unauthorized', (data) ->
        $rootScope.credentials = null
        localStorageService.set('credentials', {})
        console.log data.message

      this.socket.on 'authorized', ->
        console.log 'authorized'
        # do some action on authorized

      this.subscribe credentials, room

    subscribe: (credentials, room) ->
      this.room = "#{credentials.prefix}::#{room}"
      this.socket.emit('subscribe', {credentials: credentials, room: room})

    unsubscribe: ->
      this.socket.emit('unsubscribe', this.room)

    socketTransmit: (data) ->
      data.room = this.room
      data.host = $rootScope.socketRole
      this.socket.emit('socketTransmit', data)
