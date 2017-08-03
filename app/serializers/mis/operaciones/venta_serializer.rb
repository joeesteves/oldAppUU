class Mis::Operaciones::VentaSerializer < ActiveModel::Serializer
  include Globalizer # Este modulo incluye los attributos
  has_many :items
end
