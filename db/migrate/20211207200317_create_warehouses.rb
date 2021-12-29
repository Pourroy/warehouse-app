class CreateWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :warehouses do |t|
      t.string :nome
      t.string :code

      t.timestamps
    end
  end
end
