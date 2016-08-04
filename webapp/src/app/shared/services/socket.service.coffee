angular.module 'App'
  .service 'SocketService', ($rootScope, socketUrl, localStorageService) ->
    'ngInject'

    socket: io.connect(socketUrl)
    credentials: null
    initiate: (credentials, room) ->
      @credentials = credentials
      this.socket.on 'socketTransmit', (data) ->
        if angular.equals data.destination, $rootScope.socketRole
          $rootScope.$broadcast 'socketTransmit', data

      # Some error handling
      this.socket.on 'unauthorized', (data) ->
        $rootScope.credentials = null
        localStorageService.set('credentials', {})

      this.socket.on 'authorized', ->
        # do some action on authorized

      this.subscribe credentials, room

    subscribe: (credentials, room) ->
      this.room = "#{credentials.prefix}::#{room}"
      this.socket.emit('subscribe', {token: credentials.token, room: credentials.prefix + '::' + room})

    unsubscribe: ->
      this.socket.emit('unsubscribe', this.room)

    socketTransmit: (data) ->
      data.room = this.room
      data.host = $rootScope.socketRole
      data.token = @credentials.token
      this.socket.emit('socketTransmit', data)
