angular.module 'appuu'
.controller 'UsuariosCtrl', ($scope, $location, $auth, Comunicacion) ->
  $scope.actualizar_password = ->
    $auth.updatePassword($scope.nueva_credencial)
    .then ->
      $location.path('/fw/sesiones/cerrar')
      $scope.nuevo_credencial = {}
    .catch (resp) ->
      Comunicacion.mostrar_errores(resp)
