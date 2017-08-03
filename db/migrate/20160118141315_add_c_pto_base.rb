class AddCPtoBase < ActiveRecord::Migration
  def change
    add_column :op_bases, :cond_pago, :string
  end
end
