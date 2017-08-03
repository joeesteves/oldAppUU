class Fw::Traductor
  attr_reader :klass, :diccionario

  def initialize(underscored_klass, options = {})
    @klass = underscored_klass.classify.constantize
    @diccionario = Fw::Diccionario.new(underscored_klass)
    @empresa_id = options[:empresa_id]
  end

  def formulario
    form_terminado.as_json
  end

  def ficha
    ficha_terminada.as_json
  end

# private

  def form_terminado
    crudo('FORMULARIO').inject({}) do |hsh, (k,v)|
      if v['input'].keys.include? 'class'
        data = {data: v['input']['class'].constantize.scoped(@empresa_id).select(:id, :nombre)}
      elsif v['input'].keys.include? 'const'
        data = {data: v['input']['const'].constantize.tipificar }
      end
      v['input'].merge!(data) if data
      hsh[k] = v
      hsh
    end

  end
  def ficha_terminada
    hsh = {}
    %w(encabezado contenido pie).each do |ub|
      hsh[ub] = crudo('FICHA').select { |k,v| v['ubicacion'] == ub }
    end
    hsh
  end


  def crudo(dicc)
    filtrado.inject({}) do |hsh, col|
      resp = diccionario.buscar({col: col, dicc: dicc})
      hsh[col] = resp if resp
      hsh
    end
  end

  def filtrado
    columnas.select { |col| col !~ /_at|^id/ }
  end

  def columnas
    if params = klass::PARAMS
      (klass::ADICIONALES | params).map(&:to_s)
    else
      klass.columns.map(&:name)
    end
  end
end
