class Ba::Producto < ActiveRecord::Base
  PARAMS = [:id, :nombre, :cta_compra, :cta_compra_id, :cta_venta_id, :impuesto_id]
  include Standard::ValidationsAbm, Scope::Comun
  belongs_to :impuesto, class_name: "Co::Impuesto"
  belongs_to :cta_compra, class_name: "Co::Cuenta"
  belongs_to :cta_venta, class_name: "Co::Cuenta"

end
