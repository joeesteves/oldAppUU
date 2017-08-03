class Pr::Servicio < Ba::Producto
  scope :scoped, -> (empresa_id) { where('id in (?)', Fw::Scope.empresa(self.to_s, empresa_id).collect(&:objeto_id) )}
  before_save :set_unidad

  private
    def set_unidad
      self.unidad = Pr::Unidad::BASE.principal
    end
end
