class AddCuentaCredyDebToImp < ActiveRecord::Migration
  def change
    remove_column :co_impuestos, :cuenta_id, :integer
    add_column :co_impuestos, :c_cta_id, :integer
    add_column :co_impuestos, :d_cta_id, :integer
  end
end
