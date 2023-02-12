require 'securerandom'
class ProductModel < ApplicationRecord
  enum status: { in: 0, out: 1 }
  belongs_to :supplier
  belongs_to :category
  has_many :product_bundle_items
  validates :name, presence: true
  has_many :product_items
  before_create :generate_sku

  def generate_sku
    self.sku = SecureRandom.alphanumeric(20).upcase
  end

  def dimensions
    "#{height} x #{width} x #{length}"
  end
end
