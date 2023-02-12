class Supplier < ApplicationRecord
  has_many :product_models
  validates :namesoc, :ficname, :cnpj, :email, presence: true
  validates :cnpj,  length: { is: 13 }
  validates :cnpj, uniqueness: true
end
