angular.module 'App'
  .config ($logProvider, $httpProvider, localStorageServiceProvider) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    $httpProvider.interceptors.push('AuthenticationInterceptor')
    localStorageServiceProvider.setPrefix('LettersNumbers')





