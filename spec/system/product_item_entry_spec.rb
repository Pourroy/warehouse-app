require 'rails_helper'

describe 'Usuario dá entrada em novos itens' do
  it 'com sucesso' do
    # Arrange
    c = Category.create!(name: 'Produto novo')
    user = User.create(email: 'admin@email.com', password: '12345678')
    w1 = Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                          address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                          postal_code: '57050-000',
                          total_area: 10_000, useful_area: 8000, category_ids: [c.id])
    supplier = Supplier.create(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                               cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                               email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                              weight: 400, supplier: supplier, category: c)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                         weight: 300, supplier: supplier, category: c)

    # Act
    login_as(user)
    visit root_path
    click_on 'Entrada de Estoque'
    fill_in 'Quantidade', with: 10
    select 'MCZ', from: 'Galpão Destino'
    select 'Pelúcia Dumbo', from: 'Produto'
    # Preço
    # Número do Lote
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq warehouse_path(w1.id)
    expect(page).to have_css('h2', text: 'ESTOQUE')
    within("div#product-#{p1.id}") do
      expect(page).to have_content('Pelúcia Dumbo')
      expect(page).to have_content('Quantidade: 10')
    end
  end
  it 'e falha' do
    # Arrange
    c = Category.create!(name: 'Produto novo')
    c2 = Category.create!(name: 'Produtos Usados')
    user = User.create(email: 'admin@email.com', password: '12345678')
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10_000, useful_area: 8000, category_ids: [c2.id])
    supplier = Supplier.create(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                               cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                               email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                         weight: 400, supplier: supplier, category: c)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                         weight: 300, supplier: supplier, category: c)

    # Act
    login_as(user)
    visit root_path
    click_on 'Entrada de Estoque'
    fill_in 'Quantidade', with: 10
    select 'MCZ', from: 'Galpão Destino'
    select 'Pelúcia Dumbo', from: 'Produto'
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq product_items_entry_path
    expect(page).to have_content 'CATEGORIA DO PRODUTO INCOMPATÍVEL COM O GAPÃO'
  end

  it 'a partir da tela do galpão' do
    # Arrange
    c = Category.create!(name: 'Produto novo')
    user = User.create!(email: 'admin@email.com', password: '12345678')
    w1 = Warehouse.create!(name: 'Alagoas', code: 'ALS', description: 'Ótimo galpão numa linda cidade',
                           address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                           postal_code: '57050-000',
                           total_area: 10_000, useful_area: 8000, category_ids: [c.id])
    supplier = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    p1 = ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                              weight: 400, supplier: supplier, category: c)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                         weight: 300, supplier: supplier, category: c)
    # Act
    login_as(user)
    visit root_path
    click_on 'Alagoas'
    fill_in 'Quantidade', with: 2
    select 'Pelúcia Dumbo', from: 'Produto'
    # Preço
    # Número do Lote
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq warehouse_path(w1.id)
    expect(page).to have_css('h2', text: 'ESTOQUE')
    within("div#product-#{p1.id}") do
      expect(page).to have_content('Pelúcia Dumbo')
      expect(page).to have_content('Quantidade: 2')
    end
  end
  it 'a partir da tela do galpão' do
    # Arrange
    c = Category.create!(name: 'Produto novo')
    user = User.create!(email: 'admin@email.com', password: '12345678')
    w1 = Warehouse.create!(name: 'Alagoas', code: 'ALS', description: 'Ótimo galpão numa linda cidade',
                           address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                           postal_code: '57050-000',
                           total_area: 10_000, useful_area: 8000, category_ids: [c.id])
    supplier = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                cnpj: '8593597200012', address: 'Av Industrial, 1000, São Paulo',
                                email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
    ProductModel.create!(name: 'Pelúcia Dumbo', height: '50', width: '40', length: '20',
                         weight: 400, supplier: supplier, category: c, status: 1)
    ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                         weight: 300, supplier: supplier, category: c)
    # Act
    login_as(user)
    visit root_path
    click_on 'Alagoas'
    fill_in 'Quantidade', with: 2
    select 'Pelúcia Dumbo', from: 'Produto'
    # Preço
    # Número do Lote
    click_on 'Confirmar'
    expect(current_path).to eq warehouse_path(w1.id)
    expect(page).to have_content 'Produto não disponível, consulte o status do produto'
    expect(page).to have_css('h2', text: 'ESTOQUE')
  end
end
