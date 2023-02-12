class ChangeColumnNomeAndAdressFromWarehousesToNameAndAddress < ActiveRecord::Migration[6.1]
  def change
    rename_column(:warehouses, :nome, :name)
    rename_column(:warehouses, :adress, :address)
  end
end
