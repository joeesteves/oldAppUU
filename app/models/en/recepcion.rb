class En::Recepcion
  attr_reader :escritorio, :corcho, :archivo

  def initialize usuario
    @usuario = usuario
    @su = Mi::Base.new @usuario
    @escritorio = @su.escritorio.principal
    @corcho = @su.escritorio.corcho
    @archivo = @su.escritorio.archivo
    check_in
  end

  def check_in
    prepara_escritorio if primera_vez?
  end

private

  def primera_vez?
    @su.entorno.sin_empresa?
  end

  def prepara_escritorio
    # chequeo que no tenga las tarjetas de recepcion ya cargadas.. puede haber tenido un primer login y no hacer ninguna accion con lo cual las tarjetas estarían
    #tarjetizo las notas de recepcion a dicho usuario
    tarjetiza_notas_recepcion unless tiene_tarjetas_de_recepcion?
  end

  def tiene_tarjetas_de_recepcion?
    !@su.escritorio.mis_tarjetas.empty?
  end

  def tarjetiza_notas_recepcion
    Fw::Nota.tagged('recepcion','sistema').each { |nota| nota.tarjetizar usuario: @usuario  }
  end
end
