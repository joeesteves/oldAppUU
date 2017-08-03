angular.module 'appuu'
.controller 'ResoursesIndexController', (ResourseManager, $scope, TarjetasManager) ->
  $scope.ficha = ResourseManager.ficha()
  Res = ResourseManager.resource()
  Res.query().$promise
  .then (data) ->
    $scope.collection = data

  $scope.path = ResourseManager.underscored_klass()

  $scope.pre_borrar = (objeto_a_borrar) ->
    $scope.objeto_a_borrar = objeto_a_borrar

  $scope.borrar = () ->
    $scope.objeto_a_borrar.$remove()
    .then ->
      $scope.collection = Res.query()

  $scope.tarjetizar = (item_id) ->
    TarjetasManager.crear(item_id, $scope.path)
