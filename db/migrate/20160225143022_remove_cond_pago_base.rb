class RemoveCondPagoBase < ActiveRecord::Migration
  def change
    remove_column :op_bases, :cond_pago
  end
end
