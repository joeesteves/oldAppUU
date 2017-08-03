class Ba::Acceso < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :empresa, class_name: 'Mi::Empresa'
  belongs_to :rol
  validates :rol, presence: true
end
