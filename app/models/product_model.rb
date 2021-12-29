require 'securerandom'
class ProductModel < ApplicationRecord
  belongs_to :supplier
  belongs_to :category
  has_many :product_bundle_items
  validates  :name,  presence: true
  
  before_create do
    self.sku = SecureRandom.hex(10).upcase
  end
  def dimensions
    "#{height} x #{width} x #{length}"
  end
end