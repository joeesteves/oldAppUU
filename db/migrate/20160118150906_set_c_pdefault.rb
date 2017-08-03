class SetCPdefault < ActiveRecord::Migration
  def change
    change_column :op_bases, :cond_pago, :string, default: '1'
  end
end
