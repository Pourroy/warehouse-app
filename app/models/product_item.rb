class ProductItem < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_model
  validates :code, uniqueness: true
  before_create :generate_code

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end
