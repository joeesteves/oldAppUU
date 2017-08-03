angular.module 'appuu'
.controller 'OperacionesCtrl', ($http, $q, $rootScope, $scope, ResourseManager, SessionManager, Calc) ->

  #rs_listo = cuando rootScope este listo carga las funciones
  rs_listo = ->
    def = $q.defer()
    if $rootScope.rs_empresa_actual != undefined
      empresa = $rootScope.rs_empresa_actual
      def.resolve(empresa)
    else
      SessionManager.empresa_actual()
      .then (resp) ->
        empresa =  resp.data.empresa
        def.resolve(empresa)
    def.promise
  set_organizaciones_url = ->
    res = switch ResourseManager.get_element()
      when 'compras'
        'proveedores'
      when 'ventas'
        'cliente'
    'mis/organizaciones/' + res

    # hacer funcion que devueva la operacion compra venta etc y decidir cliente prov en base a eso
    #   when '/mis/operaciones/compras/'

  rs_listo().then (data) ->
    organizaciones_url = set_organizaciones_url()
    asociated_collections = {'Productos': 'pr/servicios/', 'Organizaciones': organizaciones_url}
    switch data.cat_fiscal
      # when 'mona'
      when 'repo'
        asociated_collections['Impuestos'] = 'co/impuestos'
    asociated_collections

    ResourseManager.set_collections($scope, asociated_collections).then ->

      ResourseManager.set_scope($scope).then ->
        $http.get('/mis/operaciones/compras/ultimas_condiciones').then (resp) ->
            $scope.ultimas_condiciones = resp.data
            console.log resp.data
            $scope.modo_pago = $scope.ultimas_condiciones[0].tipo
        $scope.set_cond_pago_tipo()
      $scope.ch = (item, req_by) ->
        switch req_by
          when 'producto'
            calcular_importe(item)
            item.imp_mod = undefined
          when null
            calcular_importe(item)
          else
            check_importe(item)
            get_imp(item, req_by) if data.cat_fiscal == 'repo'
        calcular_globales(req_by) if req_by != 'init'


    $scope.set_cond_pago_tipo = ->
      $scope.cond_pago_tipo = if $scope.op.condiciones[0].forma.match(/^[a-z](\d{1,2})/)
        'Cuotas'
      else if $scope.op.condiciones[0].forma.match(/\d+:\d+/)
        'Irregulares (dias:porcentaje)'
      else if $scope.op.condiciones[0].forma.match(/^\d{1,3}(?:(?:,|\s|y)+(?:\d{1,3})?)*$/)
        switch $scope.op.condiciones[0].forma
          when '0' then 'Hoy'
          when '1' then 'Día'
          else 'Dias'
      else
       'Indefinida'

    $scope.cond_pago_tipo = 'Hoy'

    $scope.change_modo_pago = ->
      condiciones = $scope.ultimas_condiciones
      next = condiciones.findIndex( (i) -> i.tipo == $scope.modo_pago) + 1
      next = 0 if next == condiciones.length
      condicion = condiciones[next]
      $scope.modo_pago = condicion.tipo
      $scope.op.condiciones[0] = {cuenta_id: condicion.cuenta_id, forma: '0'}



    $scope.modal_cp = ->
      $scope.get_condiciones()
      $('#modal_condiciones').modal()

    $scope.add_item = ->
      $scope.op.items.push({producto_id: null, cantidad: 1})

    $scope.delete_item = (item)->
      item._destroy = true
      calcular_globales(null)

    $scope.next_imp = (item) ->
      i = $scope.impuestos.findIndex (impuesto) ->
        impuesto.id == item.impuesto_id
      cantidad = $scope.impuestos.length
      next_i = (i + 1) % cantidad
      impuesto = $scope.impuestos[next_i]
      item.impuesto_id = impuesto.id
      item.imp_alic = impuesto.alicuota
      calcular_globales()


    calcular_importe = (item) ->
      item.importe = Calc.pxq(item)
      item.ed_manual = false
    check_importe = (item) ->
      item.ed_manual = (Calc.pxq(item) != parseFloat(item.importe))

    calcular_globales = (req_by) ->
      bruto = impuesto = 0
      angular.forEach $scope.op.items, (item) ->
        return if item._destroy == true
        bruto += parseFloat(item.importe)
        if data.cat_fiscal == 'repo'
          item.impuesto = parseFloat(item.importe * get_imp(item, req_by).coef)
          impuesto += parseFloat(item.impuesto)
      $scope.op.bruto = parseFloat(bruto.toFixed(2))
      $scope.op.impuesto = parseFloat(impuesto.toFixed(2))
      $scope.op.total = parseFloat( (bruto + impuesto).toFixed(2) )

        # item.impuesto_id = item.impuesto_id || get_imp(item.producto_id).id
    get_imp = (item, req_by) ->
      if req_by == 'producto' && item.imp_mod == undefined
        p = $scope.productos.filter (producto) ->
          producto.id == item.producto_id
        impuesto = get_imp_by_id p[0].impuesto_id
        item.imp_mod = undefined
        item.impuesto_id = impuesto.id
        item.imp_alic = impuesto.alicuota
        impuesto
      else if item.impuesto_id
        item.imp_mod = true
        impuesto = get_imp_by_id item.impuesto_id
        item.imp_alic = impuesto.alicuota
        impuesto

    get_imp_by_id = (imp_id) ->
      i = $scope.impuestos.filter (impuesto) ->
        impuesto.id == imp_id
      i[0]

    $scope.deshabilito = (item) ->
      [$scope.op.organizacion_id, item.producto_id].indexOf(null) != -1
