require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  it '.dimensions' do
    p = ProductModel.new(height: '14', width: '10', length: '12')
    result = p.dimensions
    expect(result).to eq '14 x 10 x 12'
  end
  it 'should generate an SKU' do
    # Arrange
    c = Category.create!(name: 'Teste')
    supplier1 = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                 cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    p = ProductModel.new(name: 'Monitor Gamer', supplier: supplier1, weight: '2000',
                         height: '14', width: '10', length: '12', category: c)
    # Act
    p.save
    # Assert
    expect(p.sku).not_to eq nil
    expect(p.sku.length).to eq 20
  end

  it 'should generate a random SKU' do
    # Arrange
    c = Category.create!(name: 'Teste')
    supplier1 = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                 cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    p = ProductModel.new(name: 'Monitor Gamer', supplier: supplier1, weight: '2000',
                         height: '14', width: '10', length: '12', category: c)
    allow(SecureRandom).to receive(:alphanumeric).with(20).and_return '6WL0esFqq9gQMDGrYBjV'
    # Act
    p.save
    # Assert
    expect(p.sku).to eq '6WL0ESFQQ9GQMDGRYBJV'
  end

  it 'should not update sku' do
    # Arrange
    c = Category.create!(name: 'Teste')
    supplier1 = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                 cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', tel: '11 1234-5678')

    p = ProductModel.new(name: 'Monitor Gamer', supplier: supplier1, weight: '2000',
                         height: '14', width: '10', length: '12', category: c)
    p.save
    sku = p.sku
    # Act
    p.update(name: 'Monitor 4k')
    # Assert
    expect(p.name).to eq 'Monitor 4k'
    expect(p.sku).to eq sku
  end
end
