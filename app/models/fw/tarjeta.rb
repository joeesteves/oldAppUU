class Fw::Tarjeta < ActiveRecord::Base
  ESTADOS = {
    pendientes:  {id: 1, accion: 'fijar'},
    postergadas: {id: 2, accion: 'postergar'},
    canceladas:  {id: 3, accion: 'cancelar'},
    archivadas:  {id: 0, accion: 'archivar'}
  }

  ESTADOS.each do |k,v|
    scope k.to_sym, -> { where(estado: v[:id])}
  end
  scope :dirigidas_a, ->  (usuario_id) { where("#{usuario_id} = ANY (dirigida_a)") }
  scope :scoped, -> {order(:id)}

  end
