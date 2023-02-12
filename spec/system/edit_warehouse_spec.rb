require 'rails_helper'

describe 'Usuário edita infomações da warehouse' do
  it 'com sucesso' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                      postal_code: '57050-000', address: 'Av Fernandes Lima',
                      city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)
    visit root_path
    find('div#MCZ').click_on('Editar')
    fill_in 'Nome', with: 'Maceitest'
    fill_in 'Código', with: 'MCO'
    click_on 'Gravar'

    expect(page).to have_content 'Galpão editado com sucesso'
    expect(page).to have_content 'Maceitest'
    expect(page).not_to have_content 'MCZ'
  end

  it 'com sucesso selecionando categorias' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Category.create!(name: 'Roupa Infantil')
    Category.create!(name: 'Roupa de Gala')
    Category.create!(name: 'Roupas Sensuais')
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                      postal_code: '57050-000', address: 'Av Fernandes Lima',
                      city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)

    visit root_path
    find('div#MCZ').click_on('Editar')

    fill_in 'Nome', with: 'Maceitest'
    fill_in 'Código', with: 'MCO'
    check 'Roupas Sensuais'
    click_on 'Gravar'

    expect(page).to have_content 'Galpão editado com sucesso'
    expect(page).to have_content 'Maceitest'
    expect(page).to have_content 'Roupas Sensuais'
    expect(page).not_to have_content 'Roupa Infantil'
    expect(page).not_to have_content 'Roupa de Gala'
    expect(page).not_to have_content 'MCZ'
  end
  it 'e falha' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                          postal_code: '57050-000', address: 'Av Fernandes Lima',
                          city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)

    visit root_path
    find('div#MCZ').click_on('Editar')
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
    expect(current_path).to eq warehouse_path(w.id)
  end
end
