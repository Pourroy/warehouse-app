require 'rails_helper'

describe 'Usuário cria uma conta' do
  
  it 'com sucesso' do

    visit root_path
    click_on 'Logar'
    click_on 'Cadastre-se'
    within('form#new_user') do
      fill_in 'E-mail', with: 'ruaao@email.com'
      fill_in 'Senha', with:'12345678'
      fill_in 'Confirme sua senha', with:'12345678'
      click_on 'Sign up'
    end

  expect(current_path).to eq root_path
  expect(page).to have_content 'Olá, ruaao@email.com'
  expect(page).to have_link 'Sair'
  expect(page).not_to have_link 'Logar'
  expect(page).not_to have_link 'Cadastre-se'

  end
end