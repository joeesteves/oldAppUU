angular.module 'appuu'
.controller 'ArchivoCtrl', ($scope, ResourseManager, TarjetasManager) ->

  corcho = ResourseManager.resource()
  corcho.query().$promise
  .then (data) ->
    $scope.collection = data

  $scope.fijar = (item_id, index) ->
    TarjetasManager.fijar(item_id)
    .then ->
      $scope.collection.splice(index, 1)
  $scope.postergar = (item_id, index) ->
    TarjetasManager.postergar(item_id)
    .then ->
      $scope.collection.splice(index, 1)
