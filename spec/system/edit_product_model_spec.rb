require 'rails_helper'

describe 'Usuário tenta editar modelo de produto' do
  it 'com sucesso' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    c = Category.create!(name: 'Categoriatest')
    s = Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                         address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    pd = ProductModel.create!(name: 'Caneca SW', height: '14', width: '8', length: '8',
                              weight: 300, sku: 'SWEASEKLA', supplier: s, category: c)
    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    click_on 'Canekas Geek'
    find_link('Editar', href: edit_product_model_path(pd.id)).click
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: '301'
    fill_in 'Altura', with: '15'
    fill_in 'Largura', with: '10'
    fill_in 'Profundidade', with: '10'
    fill_in 'Código SKU', with: '234JFGO234OLK223'
    select 'Canekas Geek', from: 'Fornecedor'
    select 'Categoriatest', from: 'Categoria do Produto'
    click_on 'Gravar'

    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content 'Produto editado com sucesso'
    expect(page).to have_content 'Peso: 301 gramas'
    expect(page).to have_content 'Dimensões: 15 x 10 x 10'
    expect(page).to have_content 'Código SKU: 234JFGO234OLK223'
    expect(page).to have_content 'Categoria: Categoriatest'
  end
  it 'e falha' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    c = Category.create!(name: 'Categoriatest')
    s = Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                         address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    pd = ProductModel.create!(name: 'Caneca SW', height: '14', width: '8',
                              length: '8', weight: 300, sku: 'SWEASEKLA', supplier: s, category: c)
    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    click_on 'Canekas Geek'
    find_link('Editar', href: edit_product_model_path(pd.id)).click

    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Código SKU', with: ''
    select 'Canekas Geek', from: 'Fornecedor'
    select 'Categoriatest', from: 'Categoria do Produto'
    click_on 'Gravar'

    expect(page).to have_content 'Verifique os campos abaixo:'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).not_to have_content 'Produto editado com sucesso'
    expect(current_path).to eq product_model_path(pd.id)
  end
end
