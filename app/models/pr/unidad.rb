class Pr::Unidad
  datos = YAML.load File.open Rails.root.join "app","diccionarios","unidades.yml"
  datos.each { |k,v| const_set( k.upcase, v.inject({}) {|h,(k,v)| h[k] = v['sym']; h } )}
  ALL  = datos.inject({}) {|h,(k,v)| v.each {|k,v| h[k] = v['sym'] }; h }

  #le da cierta flexibilidad podemos buscar VOL o PES y trae las unidades minimos 3 char.
  def self.const_missing name
    if (match = self.constants.select { |c| c =~ /#{name.upcase}/ }.first) && name.size > 2
      const_get(match.to_s)
    else
      super
    end
  end

end
