class Warehouse < ApplicationRecord
        validates :nome, :code, :postal_code, presence: true
        validates :code, uniqueness: true
        validates :postal_code, format: { with: /\d{5}-\d{3}/ }
      end
      

