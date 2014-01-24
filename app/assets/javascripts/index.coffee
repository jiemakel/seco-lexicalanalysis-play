'use strict'

angular.module('index',['play.routing'])
  .controller('IdentifyCtrl', ($scope, playRoutes) ->
    $scope.text = "The quick brown fox jumps over the lazy dog"
    $scope.$watch('text', _.throttle((text) ->
      playRoutes.controllers.LexicalAnalysisController.identifyGET(text).get().success((data) ->
        $scope.errorStatus = ''
        $scope.guessedLang=data
      ).error((data,status) ->
        if (status==0)
          $scope.errorStatus = 503
          $scope.error = "Service unavailable"
        else
          $scope.errorStatus = status
          $scope.error = data
      )
    ,1000))
  )
  .controller('LemmatizeCtrl', ($scope, playRoutes) ->
    $scope.text = "Albert osti fagotin ja töräytti puhkuvan melodian."
    $scope.$watchCollection('[text,locale]', _.throttle(() ->
      locale = $scope.locale
      if locale=='' then locale=null
      playRoutes.controllers.LexicalAnalysisController.baseformGET($scope.text,locale).get().success((data) ->
        $scope.errorStatus = ''
        $scope.baseform=data
      ).error((data,status) ->
        if (status==0)
          $scope.errorStatus = 503
          $scope.error = "Service unavailable"
        else
          $scope.errorStatus = status
          $scope.error = data
      )
    ,1000))
  )
  .controller('AnalyzeCtrl', ($scope, playRoutes) ->
    $scope.text = "Albert osti"
    $scope.locale = "fi"
    $scope.$watchCollection('[text,locale]', _.throttle(() ->
      locale = $scope.locale
      if locale=='' then locale=null
      playRoutes.controllers.LexicalAnalysisController.analyzeGET($scope.text,locale).get().success((data) ->
        $scope.analysis=data
      ).error((data,status) ->
        if (status==0)
          $scope.errorStatus = 503
          $scope.error = "Service unavailable"
        else
          $scope.errorStatus = status
          $scope.error = data
      )
    ,1000))
  )
  .controller('InflectionCtrl', ($scope, playRoutes) ->
    $scope.text = "Albert osti fagotin ja töräytti puhkuvan melodian."
    $scope.locale = "fi"
    $scope.baseform=true;
    $scope.forms = "V N Nom Sg, N Nom Pl, A Pos Nom Pl"
    $scope.$watchCollection('[text,locale,baseform,forms]', _.throttle(() ->
      locale = $scope.locale
      if locale=='' then locale=null
      playRoutes.controllers.LexicalAnalysisController.inflectGET($scope.text, $scope.forms.split(/, */),$scope.baseform,locale).get().success((data) ->
        $scope.inflection=data
      ).error((data,status) ->
        if (status==0)
          $scope.errorStatus = 503
          $scope.error = "Service unavailable"
        else
          $scope.errorStatus = status
          $scope.error = data
      )
    ,1000))
  )
  .controller('HyphenationCtrl', ($scope, playRoutes) ->
    $scope.text = "Albert osti fagotin ja töräytti puhkuvan melodian."
    $scope.$watchCollection('[text,locale]', _.throttle(() ->
      locale = $scope.locale
      if locale=='' then locale=null
      playRoutes.controllers.LexicalAnalysisController.hyphenateGET($scope.text,locale).get().success((data) ->
        $scope.hyphenation=data
      ).error((data,status) ->
        if (status==0)
          $scope.errorStatus = 503
          $scope.error = "Service unavailable"
        else
          $scope.errorStatus = status
          $scope.error = data
      )
    ,1000))
  )