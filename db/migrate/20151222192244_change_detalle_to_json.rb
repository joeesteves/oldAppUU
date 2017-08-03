class ChangeDetalleToJson < ActiveRecord::Migration
  def change
    remove_column :op_bases, :detalle 
    add_column :op_bases, :detalle, :json, default: {}, null: false
  end
end
