angular.module 'appuu'
.factory 'Calc', () ->
  pxq: (item) ->
    parseFloat( (item.precio * item.cantidad).toFixed(2) )
