class AddImpuestoToItems < ActiveRecord::Migration
  def change
    add_column :op_items, :impuesto, :decimal, precision: 10, scale: 2, default: 0.00
  end
end
