class Mi::Entorno < Mi
  def sin_empresa?
    @usuario.empresas.empty?
  end

  def invitaciones
    []
  end

  def solicitar_invitacion
  end

  def panel
    # devuleve un panel con tarjeta de acuerdo a la ultima vez que entro
  end

end
