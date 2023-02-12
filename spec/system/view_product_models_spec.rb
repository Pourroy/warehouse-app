require 'rails_helper'

describe 'Usuário vê lista de modelos de produto' do
  it 'com sucesso' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    c = Category.create!(name: 'Produto novo')
    supplier = Supplier.create(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                               cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                               email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                         weight: 400, supplier: supplier, category: c)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                         weight: 300, supplier: supplier, category: c)

    visit root_path
    click_on 'Lista de Modelos de Produto'

    expect(page).to have_content 'Lista de Modelos de produtos'
    expect(page).to have_content 'Pelúcia Dumbo'
    expect(page).to have_content 'Caneca Star Wars'
  end
end
