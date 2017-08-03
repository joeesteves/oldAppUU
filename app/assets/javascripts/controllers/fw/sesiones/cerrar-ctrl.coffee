angular.module 'appuu'
.controller 'CerrarSesionCtrl', ($auth, $location) ->
  $auth.signOut()
  .then ->
    $location.path('/')
