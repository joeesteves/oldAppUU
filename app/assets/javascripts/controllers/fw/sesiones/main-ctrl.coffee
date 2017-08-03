angular.module 'appuu'
.controller 'SesionCtrl', ($scope, $location, $auth, Comunicacion) ->
  $scope.pantalla = 'principal'
  $scope.iniciar_sesion = ->
    $auth.submitLogin($scope.credencial)
    .then ->
      $location.path('mi/escritorio')
      $scope.credencial = {}
    .catch (resp) ->
      Comunicacion.mostrar_errores(resp)
  $scope.cambiar_pantalla = (pantalla) ->
    try
      $scope.reseteable = {email: $scope.credencial.email}
    $scope.pantalla_anterior = $scope.pantalla
    $scope.pantalla = pantalla
  $scope.volver = ->
    $scope.pantalla = 'principal'
  $scope.crear_cuenta = ->
    $auth.submitRegistration($scope.nueva_cuenta)
    .then ->
      $scope.cambiar_pantalla('solicitud_enviada')
      $scope.nueva_cuenta = {}
    .catch (resp) ->
      Comunicacion.mostrar_errores(resp)
  $scope.reset_password = ->
    $auth.requestPasswordReset($scope.reseteable)
    .then (resp) ->
      $scope.mensaje_respuesta = resp.data.message
      $scope.cambiar_pantalla('solicitud_enviada')
      $scope.nuevo_credencial = {}
    .catch (resp) ->
      Comunicacion.mostrar_errores(resp)
