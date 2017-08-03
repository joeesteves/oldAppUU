angular.module('appuu')
.directive 'longClick', () ->
  restrict: 'A'
  link: (scope, elm, attr) ->
    elm.bind 'mousedown', ->
      scope.a = new Date()
    elm.bind 'mouseup', ->
      b = new Date()
      run = JSON.parse(attr.longClick)
      if (b - scope.a) > 250
        eval("scope." + run.long)
      else
        eval("scope." + run.short)
      scope.$apply()
