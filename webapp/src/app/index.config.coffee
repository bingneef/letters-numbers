angular.module 'App'
  .config ($logProvider, $httpProvider, $compileProvider, localStorageServiceProvider) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled false
    $compileProvider.debugInfoEnabled false
    # Set options third-party lib
    $httpProvider.interceptors.push('AuthenticationInterceptor')
    localStorageServiceProvider.setPrefix('LettersNumbers')





