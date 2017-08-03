angular.module 'appuu'
.factory 'ResourseManager', ($q, $http, $resource, $location, $routeParams, Comunicacion, FichaProvider) ->
  form: ->
    $http.post('/fw/traductor/form', {location: @.underscored_klass()})
  ficha: ->
    $http.post('/fw/traductor/ficha', {location: @.underscored_klass()})
  resource: ->
    $resource(@.underscored_klass() + "/:id", {id: "@id"}, {update: {method: "PUT"}, new: {method: "GET", url: @.underscored_klass() + "/new" }})
  underscored_klass: (args)->
    loc = args || $location.path()
    loc.match(/\/?(\w+\/\w+(?:\/(?!new|edit)[a-z]+)?)/)[1]
  get_element: (args) ->
    @.underscored_klass(args).match(/(\w+)$/)[1]

  construir_ficha: (meta_datos) ->
    ficha = FichaProvider
    ficha.header().concat(ficha.body(meta_datos), ficha.footer()).join('')
  manual_resource: (location) ->
    $resource(@.underscored_klass(location) + "/:id", {id: "@id"}, {update: {method: "PUT"}, new: {method: "GET", url: @.underscored_klass(location) + "/new" }})
  get_accion: ->
     if accion = $location.path().match(/\/([a-zA-Z]+)$/)
       accion[1]
     else # cuando es numerico como es el caso de update /compras/22
      'edit'
  set_collections: (scope, args) ->
    def = $q.defer()
    Rm = @
    regresiva = Object.keys(args).length
    angular.forEach args, (v, k) ->
      Rm.manual_resource(v).query().$promise
      .then (data) ->
        scope[k.toLowerCase()] = data
        regresiva -= 1
        def.resolve() if regresiva == 0
    def.promise

  set_scope: (scope) ->
    def = $q.defer()
    Rm = @
    Obj = @.resource()
    switch @.get_accion()
      when 'new'
        guardar = '$save'
        scope.op = new Obj()
        scope.op.$new().then (data) ->
          scope.op = data
          scope.op.fecha = new Date()
          def.resolve()
      when 'edit'
        guardar = '$update'
        @.resource().get {id: $routeParams.id}, (data) ->
          scope.op = data
          scope.op.fecha = new Date(data.fecha)
          def.resolve()
    scope.guardar = ->
      scope.op[guardar]()
      .then () ->
        $location.path(Rm.underscored_klass())
      .catch (err) ->
        Comunicacion.mostrar_errores(err)
    def.promise
