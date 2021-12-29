require 'rails_helper'

describe 'Usuário edita infomações da warehouse' do
  it 'com sucesso' do
    
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)

    Warehouse.create(nome: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade', 
                    postal_code: '57050-000', adress: 'Av Fernandes Lima', 
                    city: 'Maceió', state: 'AL', total_area: 10000, useful_area: 8000)

    visit root_path
    find('div#MCZ').click_on('Editar')

    fill_in 'Nome', with: 'Maceitest'
    fill_in 'Código', with: 'MCO'
    click_on 'Gravar'

    expect(page).to have_content 'Galpão editado com sucesso'
    expect(page).to have_content 'Maceitest'
    expect(page).not_to have_content 'MCZ'
  end
  it 'usuário falha em editar o galpão' do

  user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)

    Warehouse.create(nome: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade', 
                    postal_code: '57050-000', adress: 'Av Fernandes Lima', 
                    city: 'Maceió', state: 'AL', total_area: 10000, useful_area: 8000)

    visit root_path
    find('div#MCZ').click_on('Editar')

    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Área Total', with: ''
    fill_in 'Área Útil', with: ''
    click_on 'Gravar'

    
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'CEP não é válido'
    expect(page).not_to have_content 'Galpão editado com sucesso'
  end
end