require 'rails_helper'

describe 'Usuário abre a homepage vai até a lista de fornecedores' do
  it 'e vê os fornecedores cadastrados' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Supplier.create(namesoc: 'TESTNAME', ficname: 'TESTFIC', cnpj: 'testcnpjgrava',
                    address: 'rua test', email: 'test@test.com', tel: '4002-8922')
    visit root_path
    click_on 'Lista de fornecedores cadastrados'

    expect(page).to have_css('h1', text: 'WareHouse App')
    expect(page).to have_css('h3', text: 'Boas vindas a lista de fornecedores')
    expect(page).to have_css('h2', text: 'Fornecedores Cadastrados')
    expect(page).to have_content('TESTFIC')
    expect(page).to have_content('4002-8922')
  end

  it 'usuário clica no fornecedor e vê todas as informações cadastradas' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Supplier.create(namesoc: 'TESTNAME', ficname: 'TESTFIC', cnpj: 'testcnpjgrava',
                    address: 'rua test', email: 'test@test.com', tel: '4002-8922')

    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    click_on 'TESTFIC'

    expect(page).to have_content('TESTNAME')
    expect(page).to have_content('TESTFIC')
    expect(page).to have_content('CNPJ: testcnpjgrava')
    expect(page).to have_content('Endereço: rua test')
    expect(page).to have_content('Email: test@test.com')
    expect(page).to have_content('Telefone: 4002-8922')
  end

  it 'consegue voltar para a homepage' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Supplier.create(namesoc: 'TESTNAME', ficname: 'TESTFIC', cnpj: 'testcnpjgrava',
                    address: 'rua test', email: 'test@test.com', tel: '4002-8922')

    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    click_on 'TESTFIC'
    click_on 'Voltar'
    expect(current_path).to eq root_path
  end
end
