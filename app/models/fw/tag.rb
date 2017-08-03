class Fw::Tag < ActiveRecord::Base
  TIPOS = %w(general sistema)

  TIPOS.each { |tipo| scope tipo.to_sym, -> (klass, value) { where("gid like '%#{klass}%' and '#{value}' = ANY (#{tipo})") }}
end
