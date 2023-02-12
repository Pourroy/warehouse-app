class CreateCategoryWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :category_warehouses do |t|
      t.references :warehouse, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
