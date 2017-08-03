class Op::Base < ActiveRecord::Base
  PARAMS = [:id, :fecha, :comprobante, :bruto, :impuesto, :total, :organizacion_id, :obs, :detalle, items_attributes: [:id, :producto_id, :precio, :cantidad, :importe, :impuesto_id, :obs, :_destroy], condiciones_attributes: [:id, :cuenta_id, :forma, :importe]]
  ADICIONALES = [:org_nombre]
  # scope :scoped, -> (empresa_id) { where(empresa_id: empresa_id) }
  validates :items, presence: {message: '- Debe haber al menos un item para la operación'}
  validates :organizacion_id, :fecha, presence: true
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true
  has_many :condiciones, dependent: :destroy
  accepts_nested_attributes_for :condiciones, allow_destroy: true
  belongs_to :asiento, class_name: 'Co::Asiento', dependent: :destroy
  belongs_to :empresa, class_name: 'Mi::Empresa'
  before_save :set_tipo unless self.class == Op::Base
  after_initialize :build_item_if_empty
  after_initialize :build_condicion_if_empty
  before_save :contabiliza

  define_method(:org_nombre) { organizacion.nombre if organizacion_id }

  validate do
    errors.delete(:condiciones)
    condiciones.each_with_index do |condicion, index|
      next if condicion.valid?
      condicion_errors = condicion.errors.full_messages
      errors[:condiciones] << "Condicion #{index}: #{condicion_errors.to_sentence}"
    end
  end

  def self.scoped(empresa_id)
    where(empresa_id: empresa_id).where(tipo: get_model_id)
  end

  def self.ultimas_condiciones(empresa_id)
    ary = []
    cajas_ids = Mis::Cuentas::Caja.scoped(empresa_id).map(&:id)
    tarjetas_ids = Mis::Cuentas::Tarjeta.scoped(empresa_id).map(&:id)
    last_op_with_caja = where(empresa_id: empresa_id).joins(:condiciones).where('op_condiciones.cuenta_id in (?)', cajas_ids).last
    if last_op_with_caja
      last_caja_id = last_op_with_caja.condiciones[0].cuenta_id
      last_caja = Mis::Cuentas::Caja.find(last_caja_id)
    else
      last_caja = Mis::Cuentas::Caja.scoped(empresa_id).last
    end




    last_op_with_tarjeta = where(empresa_id: empresa_id).joins(:condiciones).where('op_condiciones.cuenta_id in (?)', tarjetas_ids)

    unless last_op_with_tarjeta.empty?
      last_tarjeta_id = last_op_with_tarjeta.last.condiciones[0].cuenta_id
      last_tarjeta = Mis::Cuentas::Tarjeta.find(last_tarjeta_id)
    else
      last_tarjeta = Mis::Cuentas::Tarjeta.scoped(empresa_id).last
    end
    cta_cte = Co::Cuenta.find(self::K[:cta_cte_default])
    ary.push({tipo: "cta cte", nombre: cta_cte.nombre, cuenta_id: cta_cte.id }) if cta_cte
    ary.push({tipo: "caja", nombre: last_caja.nombre, cuenta_id: last_caja.id }) if last_caja
    ary.push({tipo: "tarjeta", nombre: last_tarjeta.nombre, cuenta_id: last_tarjeta.id }) if last_tarjeta
    ary
  end

  def self.posibles_condiciones(empresa_id)
    cta_cte = Co::Cuenta.find(self::K[:cta_cte_default])
    ary = []
    ary.push({tipo: "cta cte", cuentas: [{id: cta_cte.id, nombre: cta_cte.nombre}]}.as_json)
    ary.push({tipo: "caja", cuentas: Mis::Cuentas::Caja.select(:nombre, :id).scoped(empresa_id)}.as_json)
    ary.push({tipo: "tarjeta", cuentas: Mis::Cuentas::Tarjeta.select(:nombre, :id).scoped(empresa_id)}.as_json)

  end

  private
    def contabiliza
      Ad::Auxiliar.new(operacion: self).contabiliza
    end

    def build_item_if_empty
      !self.items.empty? || self.items.build
    end

    def build_condicion_if_empty
      !self.condiciones.empty? || self.condiciones.build(forma: '0')
    end

    def set_tipo
      self.tipo = self.class.get_model_id
    end

    def self.get_model_id
      self::TIPOS[model_name.element.to_sym]
    end

end

Op::Base::TIPOS = {
  ingreso: 'ingo',
  egreso: 'egro',
  compra: 'coma',
  venta: 'vena',
  cobranza: 'cona',
  pago: 'pago',
  movimiento: 'movo',
  provision: 'pron',
  presupuesto: 'preo'
}
