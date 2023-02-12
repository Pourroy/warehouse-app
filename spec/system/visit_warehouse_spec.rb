require 'rails_helper'
describe 'Visitante vê um galpão' do
  it 'e vê todos os dados cadastrados' do
    # Arrange
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     postal_code: '57050-000', address: 'Av Fernandes Lima',
                     city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)

    # Act
    visit root_path
    click_on 'Maceió'
    # Assert
    expect(page).to have_content('Maceió')
    expect(page).to have_content('MCZ')
    expect(page).to have_content('57050-000')
    expect(page).to have_content('Ótimo galpão numa linda cidade')
    expect(page).to have_content('Av Fernandes Lima')
    expect(page).to have_content('Maceió/AL')
    expect(page).to have_content('Área Total: 10000 m2')
    expect(page).to have_content('Área Útil: 8000 m2')
  end

  it 'e consegue voltar para tela inicial' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Warehouse.create(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     postal_code: '57050-000', address: 'Av Fernandes Lima',
                     city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)
    # Act
    visit root_path
    click_on 'Maceió'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end
