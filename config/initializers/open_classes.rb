class Hash
	# sirva para convertir {activo: 1} en array [{id:1, nombre:activo}]
	def tipificar
		inject([]) do |a, (k,v)|
			a.push({id: v, nombre: k.to_s.humanize})
			a.uniq {|i| i['id']}.as_json
		end
	end
def principal
	first[1]
end

end

class Array
	#REL CON TIPIFICAR ARROJA EL ID DEL PRIMER ELEMENTO DEL ARY SUPONE QUE ES EL PRINCIPAL
	def principal
		first['id']
	end

end

class ActiveRecord::Base
	PARAMS = nil
  ADICIONALES = []
end
