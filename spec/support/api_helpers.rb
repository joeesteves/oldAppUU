module ApiHelpers
  def encabezado
    {'Accept': Mime::JSON}
  end
  def encabezado_con_contenido
    {'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s}
  end

  def parse_json(resp)
    JSON.parse(resp.body, symbolize_names: true)
  end

  def pj
    JSON.parse(response.body, symbolize_names: true)
  end
end
