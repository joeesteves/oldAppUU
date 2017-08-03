class AddAsientoIdToBase < ActiveRecord::Migration
  def change
    add_column :op_bases, :asiento_id, :integer
  end
end
