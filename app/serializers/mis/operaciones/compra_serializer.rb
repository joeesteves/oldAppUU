  class Mis::Operaciones::CompraSerializer < ActiveModel::Serializer
  include Globalizer # Este modulo incluye los attributos
  has_many :items
  has_many :condiciones
  #
  # def attributes(opts = {})
  #   added = options[:add] || []
  #
  #   added.each do |sym|
  #     self.class.send(:define_method, sym) { object.send(sym)}
  #   end
  #
  #   self.class._attributes = self.class._attributes | added
  #   super(opts)
  # end
end
