require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor cadastrado' do
  it 'com sucesso' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    s = Supplier.create!(namesoc: 'Ruuan Hotdog ltda.', ficname: 'Doogão do Ruão', cnpj: 'cnpjtestregit',
                         address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    click_on 'Doogão do Ruão'

    expect(page).to have_content s.ficname
    expect(page).to have_content s.namesoc
    expect(page).to have_content "CNPJ: #{s.cnpj}"
    expect(page).to have_content "Endereço: #{s.address}"
    expect(page).to have_content "Email: #{s.email}"
    expect(page).to have_content "Telefone: #{s.tel}"
  end

  it 'e vê os produtos cadastrados do fornecedor' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    c = Category.new(name: 'TestCategory')
    s = Supplier.create!(namesoc: 'Ruuan Hotdog ltda.', ficname: 'Doogão do Ruão', cnpj: 'cnpjtestregit',
                         address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    ProductModel.create!(name: 'Caneca SW', height: '14', width: '8', length: '8',
                         weight: 300, sku: '', supplier: s, category: c)
    ProductModel.create!(name: 'Caneca BOSON DE HIGS', height: '12', width: '9', length: '9',
                         weight: 350, sku: '', supplier: s, category: c)

    visit root_path

    click_on 'Lista de fornecedores cadastrados'
    click_on 'Doogão do Ruão'

    expect(page).to have_css('h1', text: 'Doogão do Ruão')
    expect(page).to have_css('h3', text: 'Produtos deste fornecedor:')
    expect(page).to have_content('Caneca SW')
    expect(page).to have_content('Caneca BOSON DE HIGS')
  end
end
