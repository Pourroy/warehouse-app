require 'rails_helper'

describe 'Usuário tenta editar modelo de produto' do
   
  it 'com sucesso' do

    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    login_as(user, :scope => :user)
    c = Category.create!(name: 'Categoriatest')

    s = Supplier.create!(namesoc:'Canecas Geek', ficname:'Canekas Geek', cnpj:'cnpjtestregit',
                         address:'Rua deathdog', email:'ruandogs@dogue.com', tel:'31980293233')

    ProductModel.create!(name:'Caneca SW', height:'14', width:'8', length:'8', weight: 300, sku:'SWEASEKLA', supplier: s, category: c)

    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    click_on 'Canekas Geek'
    find('div#SWEASEKLA').click_on 'Editar'
    
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: '301'
    fill_in 'Altura', with: '15'
    fill_in 'Largura', with: '10'
    fill_in 'Profundidade', with: '10'
    fill_in 'Código SKU', with: '234JFGO234OLK223'
    select 'Canekas Geek', from: 'Fornecedor'
    select 'Categoriatest' , from: 'Categoria do Produto'
    click_on 'Gravar'

    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_contet 'Produto editado com sucesso'
    expect(page).to have_contet 'Peso: 301 gramas'
    expect(page).to have_contet 'Dimensões: 15x10x10'
    expect(page).to have_contet 'Código SKU: 234JFGO234OLK223'
    expect(page).to have_contet 'Categoria: Categoriatest'
  end
end
