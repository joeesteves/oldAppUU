class DeleteImpuestoFromItem < ActiveRecord::Migration
  def change
    remove_column :op_items, :impuesto
  end
end
