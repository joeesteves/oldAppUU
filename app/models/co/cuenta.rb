class Co::Cuenta < ActiveRecord::Base
  include Standard::ValidationsAbm, Scope::Comun, Standard::Taggeable
  PARAMS = [:id, :nombre, :desc, :tipo]
  before_save :set_tipo
  #validates :tipo, presence: true
  def self.all
    if self == Co::Cuenta
      super
    else
      super.where(tipo: Co::Cuenta::TIPOS[self.model_name.element.to_sym])
    end
  end

  def self.scoped(empresa_id)
    where('id in (?) and tipo like ?', Fw::Scope.empresa(self.to_s, empresa_id).collect(&:objeto_id), get_model_id )
  end

private
  def self.get_model_id
    return '%%' if self == Co::Cuenta
    self::TIPOS[model_name.element.to_sym]
  end

  def set_tipo
    self.tipo = self.class.get_model_id unless self.class == Co::Cuenta
  end
end

Co::Cuenta::TIPOS = {
    activo: '100',
     banco: '110',
   tarjeta: '111',
      caja: '120',
  deudores: '150',
    pasivo: '200',
acreedores: '250',
   capital: '300',
   ingreso: '400',
'pres ing': '450',
    egreso: '500',
 provision: '550',
 'dif inv': '600'
}

Co::Cuenta::PRINCIPALES = {
  proveedores: 1,
  clientes: 2,
  c_fiscal: 3,
  d_fiscal: 4
}
