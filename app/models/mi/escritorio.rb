class Mi::Escritorio < Mi

  def principal
    mis_tarjetas.pendientes
  end

  def corcho
    mis_tarjetas.postergadas
  end

  def archivo
    mis_tarjetas.archivadas
  end

  def mis_tarjetas
    Fw::Tarjeta.scoped.dirigidas_a(@usuario.id)
  end

end
