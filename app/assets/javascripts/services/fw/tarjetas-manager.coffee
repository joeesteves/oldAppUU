angular.module 'appuu'
.factory 'TarjetasManager', ($http) ->
  archivar: (item_id) ->
    $http.post('/mis/tarjetas/archivar', {id: item_id })
  postergar: (item_id) ->
    $http.post('/mis/tarjetas/postergar', {id: item_id })
  fijar: (item_id) ->
    $http.post('/mis/tarjetas/fijar', {id: item_id })
  crear: (objeto_id, underscored_klass) ->
    $http.post('/fw/tarjetas', {underscored_klass: underscored_klass, item_id: objeto_id })
