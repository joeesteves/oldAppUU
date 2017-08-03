angular.module 'appuu'
.controller 'ResoursesUpdateController', (Comunicacion, ResourseManager, $routeParams, $scope, $location) ->
  Resourse = ResourseManager.resource()
  form = ResourseManager.form()
  index_url = ResourseManager.underscored_klass()

  form
  .then (resp) ->
    $scope.fields = resp.data

  Resourse.get {id: $routeParams.id}, (data) ->
    $scope.obj = data

  $scope.guardar = ->
    $scope.obj.$update()
    .then () ->
      $location.path(index_url)
    .catch () ->
      alert('error')
