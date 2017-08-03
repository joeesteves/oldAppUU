angular.module 'appuu'
.factory 'FichaProvider', () ->
  header: () ->
    ['<div class="col-md-3" ng-repeat="item in collection | orderBy: \'nombre\' | filter:search | limitTo:50">
    <div class="panel panel-success"><div class="panel-heading">']
  body: (meta_datos) ->
    html_var = []
    angular.forEach meta_datos, (v, k) ->
      switch k
        when 'encabezado'
          html_var.push(['<h3 class="panel-title"><a href="#/{{path}}/{{item.id}}">'])
          angular.forEach v, (vv,kk) ->
            if kk == 'fecha'
              html_var.push(['{{item.'+kk+' | date: "mediumDate"}}'])
            else
              html_var.push(['  {{item.'+kk+' }}'])
          html_var.push(['</a></h3></div><div class="panel-body">'])
        when 'contenido'
          angular.forEach v, (vv,kk) ->
            switch vv['attrs']
              when 'marked'
                html_var.push(['<li class="list-group-item list-group-item-success" marked="item.'+kk+'"></li>'])
              when undefined
                html_var.push(['<li class="list-group-item list-group-item-success">
                <span class="'+vv["icono"]+'">
                {{item.'+kk+'}}
                </span></li>'])
            # html_var.push(['<p marked="item.'+kk+'"></p>'])
          html_var.push(['</div>'])
    html_var
  footer: ->
    ['<div class="panel-footer">'
      '<div class="row">'
      '<div class="col-md-1 ">'
      '<span class="glyphicon glyphicon-remove-circle text-danger" ng-click="pre_borrar(item)" data-toggle="modal" data-target= "#myModal">&nbsp</span>'
      '</div>'
      '<div class="col-md-10 text-right">'
      '<span class="glyphicon glyphicon-time text-success">&nbsp</span>'
      '<span class="glyphicon glyphicon-pushpin text-success" ng-click="tarjetizar(item.id)">&nbsp</span>'
      '<span class="glyphicon glyphicon-user text-success" data-toggle="modal" data-target= "#FijaEnEscritorio"></span>'
    '</div> <!-- div text right -->'
    '</div> <!-- div row -->'
    '</div> <!-- div patel foot -->'
    '</div> <!-- div repeat -->']
