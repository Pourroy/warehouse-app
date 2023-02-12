require 'rails_helper'

describe 'User change product model status' do
  it 'to out' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    c = Category.create!(name: 'Categoriatest')
    s = Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                         address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    ProductModel.create!(name: 'Caneca SW', height: '14', width: '8', length: '8',
                         weight: 300, sku: 'SWEASEKLA', supplier: s, category: c)

    visit root_path
    click_on 'Lista de Modelos de Produto'
    click_on 'Caneca SW'
    click_on 'Desativar'

    expect(page).to have_content 'Status: out'
    expect(page).to have_content 'Edição efetuada com sucesso'
    expect(page).to have_button 'Ativar'
  end
  it 'to in' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    c = Category.create!(name: 'Categoriatest')
    s = Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                         address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    ProductModel.create!(name: 'Caneca SW', height: '14', width: '8', length: '8', weight: 300,
                         sku: 'SWEASEKLA', supplier: s, category: c, status: 1)
    visit root_path
    click_on 'Lista de Modelos de Produto'
    click_on 'Caneca SW'
    click_on 'Ativar'

    expect(page).to have_content 'Status: in'
    expect(page).to have_content 'Edição efetuada com sucesso'
    expect(page).to have_button 'Desativar'
  end
end
