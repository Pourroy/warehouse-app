require 'securerandom'
class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items
  validates :name, presence: true

  before_save do
    self.sku = SecureRandom.hex(12).upcase
  end
end
