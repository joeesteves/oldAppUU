angular.module 'appuu'
.factory 'Comunicacion', ($rootScope) ->
  mostrar_errores: (resp) ->
    src = resp.data || resp
    errores = src.errors
    $rootScope.errores = []
    $rootScope.errores = switch errores.constructor
      when Object
        errores['full_messages']
      when Array
        errores
    $('#modal_errores').modal()
