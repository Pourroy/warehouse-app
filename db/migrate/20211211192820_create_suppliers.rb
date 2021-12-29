class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :namesoc
      t.string :ficname
      t.string :email
      t.string :cnpj
      t.string :tel
      t.string :address

      t.timestamps
    end
  end
end
