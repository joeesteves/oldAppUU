class AddImpuestoToProducto < ActiveRecord::Migration
  def change
    add_column :ba_productos, :impuesto_id, :integer
    remove_column :ba_productos, :imp_compra_id
    remove_column :ba_productos, :imp_venta_id
  end
end
