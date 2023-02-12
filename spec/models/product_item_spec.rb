require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  it 'should generate an code' do
    # Arrange
    c = Category.create!(name: 'Teste')
    s = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                         cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                         email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    p = ProductModel.create!(name: 'Monitor Gamer', supplier: s, weight: '2000',
                             height: '14', width: '10', length: '12', category: c)
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                          address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                          postal_code: '57050-000',
                          total_area: 10_000, useful_area: 8000)
    pi = ProductItem.new(warehouse: w, product_model: p)
    # Act
    pi.save
    # Assert
    expect(pi.code).not_to eq nil
    expect(pi.code.length).to eq 10
  end
  it 'should generate a random code' do
    # Arrange
    c = Category.create!(name: 'Teste')
    supplier1 = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                 cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    p = ProductModel.create!(name: 'Monitor Gamer', supplier: supplier1, weight: '2000',
                             height: '14', width: '10', length: '12', category: c)
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                          address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                          postal_code: '57050-000',
                          total_area: 10_000, useful_area: 8000)
    pi = ProductItem.new(warehouse: w, product_model: p)
    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return 'gQMDGrYBjV'
    # Act
    pi.save
    # Assert
    expect(pi.code).to eq 'GQMDGRYBJV'
  end
  it 'code cant be updated' do
    # Arrange
    c = Category.create!(name: 'Teste')
    supplier1 = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                 cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                                 email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    p = ProductModel.create!(name: 'Monitor Gamer', supplier: supplier1, weight: '2000',
                             height: '14', width: '10', length: '12', category: c)
    p2 = ProductModel.create!(name: 'Monitor Feio', supplier: supplier1, weight: '200',
                              height: '10', width: '7', length: '8', category: c)
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                          address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                          postal_code: '57050-000',
                          total_area: 10_000, useful_area: 8000)
    pi = ProductItem.new(warehouse: w, product_model: p)
    pi.save
    code = pi.code
    # Act
    pi.update(product_model: p2)
    pi.save
    # Assert
    expect(pi.code).to eq code
  end
end
