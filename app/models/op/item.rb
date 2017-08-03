class Op::Item < ActiveRecord::Base
  PARAMS = [:id, :precio, :cantidad, :importe, :producto_id, :impuesto_id]
  belongs_to :base
  belongs_to :producto, class_name: 'Ba::Producto'
  delegate :cta_compra_id, to: :producto
  delegate :cta_venta_id, to: :producto
  belongs_to :impuesto, class_name: 'Co::Impuesto'
  validates :producto_id, :precio, :cantidad, :importe, presence: true
end
