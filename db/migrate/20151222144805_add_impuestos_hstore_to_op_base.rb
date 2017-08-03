class AddImpuestosHstoreToOpBase < ActiveRecord::Migration
  def change
    add_column :op_bases, :detalle, :hstore, null: false, default: ''
    add_index :op_bases, :detalle, using: :gin
  end
end
