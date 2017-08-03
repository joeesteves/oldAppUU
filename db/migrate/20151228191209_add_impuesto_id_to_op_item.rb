class AddImpuestoIdToOpItem < ActiveRecord::Migration
  def change
    add_column :op_items, :impuesto_id, :integer
  end
end
