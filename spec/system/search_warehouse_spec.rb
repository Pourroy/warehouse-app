require 'rails_helper'

describe 'Usuário usa busca de warehouse da home#index' do
  it 'não logado' do
    Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
                      address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
                      postal_code: '08050-000',
                      total_area: 20_000, useful_area: 18_000)

    visit root_path

    fill_in 'Busca:', with: 'Gu'
    click_on 'Pesquisar'

    expect(current_path).to eq new_user_session_path
    expect(page).not_to have_content 'Resultados da busca'
    expect(page).not_to have_content 'Guarulhos'
    expect(page).not_to have_content 'GRU'
  end

  it 'com sucesso' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
                      address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
                      postal_code: '08050-000',
                      total_area: 20_000, useful_area: 18_000)

    visit root_path

    fill_in 'Busca:', with: 'Guarulhos'
    click_on 'Pesquisar'

    expect(page).to have_content 'Resultados da busca'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
  end

  it 'pesquisa apenas com 2 caracteres' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
                      address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
                      postal_code: '08050-000',
                      total_area: 20_000, useful_area: 18_000)

    visit root_path
    fill_in 'Busca:', with: 'Gu'
    click_on 'Pesquisar'

    expect(page).to have_content 'Resultados da busca'
    expect(page).to have_content 'Guarulhos'
    expect(page).to have_content 'GRU'
  end
end
