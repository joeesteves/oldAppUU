angular.module 'appuu'
.controller 'ResoursesNewController', ($scope, $location, Comunicacion, ResourseManager, SessionManager) ->
  Resourse = ResourseManager.resource()
  form = ResourseManager.form()
  index_url = ResourseManager.underscored_klass()

  $scope.obj = new Resourse()
  $scope.obj.$new().then (data) ->
    $scope.obj = data

  form
  .then (resp) ->
    $scope.fields = resp.data

  $scope.guardar = ->
    $scope.obj.$save()
    .then (resp) ->
      if resp.options
         SessionManager.listar_empresas() if resp.options.reload_empresas
      $location.path(index_url)
    .catch (err) ->
      Comunicacion.mostrar_errores(err)
