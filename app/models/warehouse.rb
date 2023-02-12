class Warehouse < ApplicationRecord
  validates :name, :code, :postal_code, presence: true
  validates :code, uniqueness: true
  validates :postal_code, format: { with: /\d{5}-\d{3}/ }
  has_many  :product_items
  has_many :category_warehouses
  has_many :categories, through: :category_warehouses
end
