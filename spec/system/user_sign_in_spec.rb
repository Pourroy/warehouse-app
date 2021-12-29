require 'rails_helper'

describe 'Usuário faz login' do
  it 'com sucesso' do
    # Arrange
    User.create!(email: 'joao@email.com', password: '12345678')
    # Act
    visit root_path
    click_on 'Logar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Olá, joao@email.com'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Logar'
  end

  it 'e faz logout' do
    # Arrange
    User.create!(email: 'joao@email.com', password: '12345678')
    # Act
    visit root_path
    click_on 'Logar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Sair'
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_link 'Logar'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_content 'Olá, joao@email.com'
  end
end
