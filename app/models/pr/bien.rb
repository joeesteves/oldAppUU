class Pr::Bien < Ba::Producto
  PARAMS = [:id, :nombre, :cta_compra_id, :unidad]
  scope :scoped, -> (empresa_id) { where('id in (?)', Fw::Scope.empresa(self.to_s, empresa_id).collect(&:objeto_id) )}

end
