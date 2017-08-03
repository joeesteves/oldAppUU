class SetDebeHaberDefaults < ActiveRecord::Migration
  def change
    change_column :co_items, :debe, :decimal, precision: 10, scale: 2, default: 0.00
    change_column :co_items, :haber, :decimal, precision: 10, scale: 2, default: 0.00 
  end
end
