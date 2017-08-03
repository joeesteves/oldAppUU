class CreateOpCondiciones < ActiveRecord::Migration
  def change
    create_table :op_condiciones do |t|
      t.integer :base_id
      t.integer :cuenta_id
      t.string :forma
      t.decimal :importe, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
