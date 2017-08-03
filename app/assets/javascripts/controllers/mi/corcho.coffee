angular.module 'appuu'
.controller 'CorchoCtrl', ($scope, ResourseManager, TarjetasManager) ->

  corcho = ResourseManager.resource()
  corcho.query().$promise
  .then (data) ->
    $scope.collection = data

  $scope.archivar = (item_id, index) ->
    TarjetasManager.archivar(item_id)
    .then ->
      $scope.collection.splice(index, 1)
  $scope.fijar = (item_id, index) ->
    TarjetasManager.fijar(item_id)
    .then ->
      $scope.collection.splice(index, 1)
