require 'rails_helper'

describe 'User delete a supplier' do
  it 'succefully' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                     address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    visit root_path
    click_on 'Lista de fornecedores cadastrados'
    within('div#cnpjtestregit') do
      click_on 'Delete'
    end

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor deletado com sucesso'
    expect(page).not_to have_content 'Canekas Geek'
  end
end
