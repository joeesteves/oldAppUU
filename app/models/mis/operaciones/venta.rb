class Mis::Operaciones::Venta < Op::Base
  belongs_to :organizacion, class_name: 'Ba::Organizacion'
end
Mis::Operaciones::Venta::K = {
  origen: 'haber',
  destino: 'debe',
  cta_prod: 'cta_venta_id',
  cta_imp:'d_cta_id',
  cta_cte_default: Co::Cuenta::PRINCIPALES[:clientes]
}
