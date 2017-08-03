class Mis::Operaciones::Compra < Op::Base
  belongs_to :organizacion, class_name: 'Ba::Organizacion'
end

Mis::Operaciones::Compra::K = {
  origen: 'debe',
  destino: 'haber',
  cta_prod: 'cta_compra_id',
  cta_imp:'c_cta_id',
  cta_cte_default: Co::Cuenta::PRINCIPALES[:proveedores]
}
