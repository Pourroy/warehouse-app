class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :product_models
  has_many :category_warehouses
end
