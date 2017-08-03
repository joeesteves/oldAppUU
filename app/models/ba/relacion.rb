class Ba::Relacion < ActiveRecord::Base
  TIPOS = { cliente: 0, proveedor: 1, bilateral: 3 }
  belongs_to :empresa, foreign_key: 'empresa_id', class_name: 'Mi::Empresa'
  belongs_to :organizacion, foreign_key: 'organizacion_id', class_name: 'Ba::Organizacion'
  belongs_to :cliente, foreign_key: 'organizacion_id', class_name: 'Ba::Organizacion'
  belongs_to :proveedor, foreign_key: 'organizacion_id', class_name: 'Ba::Organizacion'
  validates :tipo, presence: true
end
