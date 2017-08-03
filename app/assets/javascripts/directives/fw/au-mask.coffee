angular.module('appuu')
.directive 'auMask', ->
  restrict: 'A'
  require: 'ngModel'
  link: (scope,el,attrs,model) ->
    $(el).blur ->
      value = $(el).val()
      matches = value.match /^([abce])(?:\s?-\s?|\/)?(\d{1,4})(?:\s?-\s?|\/)(\d{1,8})$/i
      if matches && value.length < 15
        matches[2] = encerador(matches[2],4)
        matches[3] = encerador(matches[3],8)
        matches.splice(0,1)
        masked_val = matches.join('-').toUpperCase()
      else if value.length == 15
        masked_val  = value
      else
        masked_val = 'A-0000-00000000'
      model.$setViewValue(masked_val)
      model.$render()
    encerador = (val, ceros) ->
      faltan = ceros - val.length
      cero_str = ''
      if faltan > 0
        [1..faltan].forEach ->
          cero_str += '0'
        cero_str + val
      else
        val
.directive 'auCondPago', ->
  restrict: 'A'
  require: 'ngModel'
  link: (scope,el,attrs,model) ->
    $(el).blur ->
      value = $(el).val()
      matches = value.match /^[a-zA-Z]\d+$/i
