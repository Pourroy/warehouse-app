require 'rails_helper'

describe 'Usuário tenta editar informações do fornecedor' do
  
  it 'com sucesso' do
    
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    login_as(user, :scope => :user)
    Supplier.create(namesoc: 'CLARO TELEFONIA', ficname:'NET CLARO', cnpj:'testcnpjgrava', address: 'rua test', email: 'test@test.com',tel: '4002-8922')

    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    within('div#testcnpjgrava') do
      click_on 'Editar'
    end
    
    fill_in 'Razão Social', with: 'TESTNAMEMODIFIED'
    fill_in 'Nome Fantasia', with: 'TESTFICMODIFIED'
    click_on 'Gravar'

    expect(page).to have_content 'Fornecedor editado com sucesso'
    expect(page).to have_content 'TESTNAMEMODIFIED'
    expect(page).to have_content 'TESTFICMODIFIED'
    expect(page).not_to have_content 'CLARO TELEFONIA'
    expect(page).not_to have_content 'NET CLARO'
  end

  it ' e falha' do
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    login_as(user, :scope => :user)
    Supplier.create(namesoc: 'CLARO TELEFONIA', ficname:'NET CLARO', cnpj:'testcnpjgrava', address: 'rua test', email: 'test@test.com',tel: '4002-8922')

    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    within('div#testcnpjgrava') do
      click_on 'Editar'
    end
    
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    click_on 'Gravar'

    expect(page).not_to have_content 'Fornecedor editado com sucesso'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
  end
end