require 'rails_helper'

describe 'Usuário cadrastra um modelo de produto' do
  it 'visitante não vê o menu' do
    visit root_path

    click_on 'Cadastrar modelo de produto'

    expect(current_path).to eq new_user_session_path
  end

  it 'visitante não acessa diretamente o formulário' do
    visit new_product_model_path

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # arrange
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Category.create!(name: 'Categoriatest')
    Supplier.create!(namesoc: 'Ceramicas LTDA', ficname: 'Cerâmicas Geek', cnpj: 'ceramicageeek',
                     address: 'Rua ceramica', email: 'ceramicageek@ceramica.com', tel: '32980293232')
    # act
    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Caneca Star Wars'
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '14'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '12'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    select 'Categoriatest', from: 'Categoria do Produto'
    click_on 'Gravar'
    # assert
    expect(page).to have_content 'Modelo de produto registrado com sucesso'
    expect(page).to have_content 'Caneca Star Wars'
    expect(page).to have_content '300 gramas'
    expect(page).to have_content 'Dimensões: 14 x 8 x 12'
    expect(page).to have_content 'Categoria: Categoriatest'
    expect(page).to have_content 'Fornecedor: Cerâmicas Geek'
  end

  it 'campos em branco' do
    # arrange
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Category.create!(name: 'Categoriatest')
    Supplier.create!(namesoc: 'Ceramicas LTDA', ficname: 'Cerâmicas Geek', cnpj: 'ceramicageeek',
                     address: 'Rua ceramica', email: 'ceramicageek@ceramica.com', tel: '32980293232')
    # act
    visit root_path
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: 300
    fill_in 'Altura', with: '14'
    fill_in 'Largura', with: '8'
    fill_in 'Profundidade', with: '12'
    select 'Cerâmicas Geek', from: 'Fornecedor'
    select 'Categoriatest', from: 'Categoria do Produto'
    click_on 'Gravar'

    # assert
    expect(page).not_to have_content 'Modelo de produto registrado com sucesso'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end
