require 'rails_helper'

describe 'Usuário acessa a lista de categorias' do
  it 'com sucesso' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Category.create!(name: 'Produto novo')

    visit root_path
    click_on 'Ver categorias de produtos'

    expect(page).to have_content 'Estas são todas as categorias registradas'
    expect(page).to have_content 'Categorias de Produtos'
    expect(page).to have_content 'Produto novo'
  end

  it 'e acessa uma categoria cadastrada' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    s = Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                         address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    c = Category.create!(name: 'Produto novo')
    ProductModel.create!(name: 'Caneca SW', height: '14', width: '8', length: '8',
                         weight: 300, supplier: s, category: c)

    visit root_path
    click_on 'Ver categorias de produtos'
    click_on 'Produto novo'

    expect(page).to have_content 'Produto novo'
    expect(page).to have_content 'Caneca SW'
    expect(current_path).to eq category_path(c.id)
  end
end
