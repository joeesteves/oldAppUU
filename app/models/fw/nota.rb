class Fw::Nota < ActiveRecord::Base
  PARAMS = [:id, :titulo, :contenido]
  include Standard::Tarjeteable, Standard::Taggeable
  scope :scoped, -> (usuario) {where(usuario_id: usuario)}
  after_update :revisar_tarjeta_asociada

private

  def revisar_tarjeta_asociada
    sec = Ad::Secretaria.new({tarjeteable: self})
    sec.update
  end
end
