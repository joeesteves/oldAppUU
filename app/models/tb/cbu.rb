module Tb
end
class Tb::Cbu
	attr_accessor :cbu, :cuenta, :banco, :sucursal
# se inicializa con el cbu o banco, sucursal y cuenta
# banco, sucursal y cuenta se completan con 0 la izq hasta la long adecueta
# si empiezan con 0 hay que pasarlo directamente como string
# valid chequea los dos digitos verificadores contra sus bloques
# corregir, crea un cbu valido para los bloques

	def initialize(datos = {})
		datos.each do |k,v|
			formatear_y_setear(k,v)
		end
		@cbu ||= gen_cbu
	end

	def valid?
		cbu.length == 22 && cbu == gen_cbu
	end

	def corregir
		@cbu = gen_cbu
	end


private
	def formatear_y_setear(k,v)
		v = v.to_s
		unless k == :cbu
			longitud = {cuenta: 13, banco: 3, sucursal: 4}
			ceros = longitud[k] - v.length
			ceros.times { v = '0' + v	}
		else
			@banco = v[0..2]
			@sucursal = v[3..6]
			@cuenta = v[8..20]
		end

		instance_variable_set('@' + k.to_s, v)
	end

	def dv(codigo)
		ponderador = '9713'.reverse * 4
		codigo_inv = codigo.reverse
		suma = 0
		codigo_inv.each_char.with_index do |item, index|
			suma += item.to_i * ponderador[index].to_i
		end
		digito_suma = suma.to_s[-1]
		if digito_suma == '0'
			'0'
		else
			(10 - digito_suma.to_i).to_s
		end
	end

	def bloque
		[banco + sucursal, cuenta]
	end

	def gen_cbu
		bloque[0] + dv(bloque[0]) + bloque[1] + dv(bloque[1])
	end


end
