angular.module 'appuu'
.factory 'SessionManager', ($rootScope, $route, $http, Comunicacion, ResourseManager) ->
  empresa_actual: ->
    $http.get('/sesion')
  cambiar_empresa: (id) ->
    $http.post('/sesion/cambiar_empresa', {id: id})
    .then (resp) ->
      $rootScope.rs_empresa_actual = resp.data.empresa
      $route.reload()
    .catch (err) ->
      Comunicacion.mostrar_errores(err)
  listar_empresas: ->
    ResourseManager.manual_resource('mi/empresa').query().
    $promise
    .then (data) ->
      $rootScope.rs_empresas = data
