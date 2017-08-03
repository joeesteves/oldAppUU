class Mis::Cuentas::Caja < Co::Cuenta
  scope :scoped, -> (empresa_id) { where('id in (?)', Fw::Scope.empresa(self.to_s, empresa_id).collect(&:objeto_id) )}
end
