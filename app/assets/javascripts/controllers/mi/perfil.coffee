angular.module 'appuu'
.controller 'PerfilCtrl', ($scope, $location, $http, ResourseManager) ->
  $http.get('/mi/perfil').then (resp) ->
    $scope.obj = resp.data
  form = ResourseManager.form('ba/usuarios')
  index_url = '/'

  form
  .then (resp) ->
    $scope.fields = resp.data


  $scope.guardar = ->
    $http.post('/mi/perfil/update', $scope.obj )
    .then () ->
      $location.path('/')
    .catch () ->
      alert('error')
