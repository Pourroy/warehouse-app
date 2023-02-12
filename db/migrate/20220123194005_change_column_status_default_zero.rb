class ChangeColumnStatusDefaultZero < ActiveRecord::Migration[6.1]
  def change
    change_column :product_models, :status, :integer , default:0
  
  end
end
