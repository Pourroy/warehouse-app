require 'rails_helper'

describe 'Visitor navigates' do
  it 'using the menu' do
    User.create!(email: 'ruaaao@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'ruaaao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    # Assert 1
    expect(page).to have_css('nav', text: 'Cadastrar novo galpão')
    expect(page).to have_css('nav', text: 'Início')
    # Assert 2
    within('nav') do
      expect(page).to have_link('Início', href: root_path)
      expect(page).to have_link('Cadastrar novo galpão')
    end
  end
end
