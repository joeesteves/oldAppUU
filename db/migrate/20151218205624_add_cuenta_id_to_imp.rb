class AddCuentaIdToImp < ActiveRecord::Migration
  def change
    add_column :co_impuestos, :cuenta_id, :integer
  end
end
