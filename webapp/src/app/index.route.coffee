angular.module 'App'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'slave',
        abstract: true
        views:
          'navigation':
            controller: 'NavigationController'
            templateUrl: 'app/navigation/navigation.html'
      .state 'slave.letters-numbers',
        url: '/slave/letters-numbers'
        views:
          '@':
            templateUrl: 'app/letters-numbers/letters-numbers-slave.html'
            controller: 'LettersNumbersSlaveController'
            controllerAs: 'letters-numbers-slave'
      .state 'fs',
        abstract: true

      .state 'fs.login',
        url: '/login'
        views:
          '@':
            templateUrl: 'app/login/login.html'
            controller: 'LoginController'
            controllerAs: 'login'

      .state 'app',
        abstract: true
        views:
          'navigation':
            controller: 'NavigationController'
            templateUrl: 'app/navigation/navigation.html'
      .state 'app.letters-numbers',
        url: '/letters-numbers'
        views:
          '@':
            templateUrl: 'app/letters-numbers/letters-numbers.html'
            controller: 'LettersNumbersController'
            controllerAs: 'letters-numbers'

    $urlRouterProvider.otherwise '/login'
