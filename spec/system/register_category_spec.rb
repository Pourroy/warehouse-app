require 'rails_helper'

describe 'Usuário cadastra uma categoria' do
  it 'com sucesso' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)

    visit root_path
    click_on 'Cadastrar categoria de produtos'

    fill_in 'Categoria do Produto', with: 'Vestuário Feminino'
    click_on 'Gravar'

    expect(page).to have_content 'Categoria registrada com sucesso'
    expect(current_path).to eq root_path

  end

  it 'e falha' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)

    visit root_path
    click_on 'Cadastrar categoria de produtos'

    fill_in 'Categoria do Produto', with: ''
    click_on 'Gravar'

    expect(page).not_to have_content 'Categoria registrada com sucesso'
    expect(current_path).not_to eq root_path
    expect(page).to have_content 'Categoria do Produto não pode ficar em branco'
  end

  it 'e não está autencicado' do
    visit root_path
    click_on 'Cadastrar categoria de produtos'
    expect(current_path).to eq new_user_session_path
  end

  it ' e tenta forçar acesso pelo link' do
    visit new_category_path

    expect(current_path).to eq new_user_session_path
  end
end
