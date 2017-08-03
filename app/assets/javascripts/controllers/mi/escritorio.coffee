angular.module 'appuu'
.controller 'EscritorioCtrl', ($scope, ResourseManager, TarjetasManager) ->
  escritorio = ResourseManager.resource()
  escritorio.query().$promise
  .then (data) ->
    $scope.collection = data

  $scope.archivar = (item_id, index) ->
    TarjetasManager.archivar(item_id)
    .then ->
      $scope.collection.splice(index, 1)
  $scope.postergar = (item_id, index) ->
    TarjetasManager.postergar(item_id)
    .then ->
      $scope.collection.splice(index, 1)
