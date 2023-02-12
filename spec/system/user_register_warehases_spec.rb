require 'rails_helper'

describe 'Usuárior cadastra um galpão' do
  it 'visitante não vê o menu' do
    visit root_path
    click_on 'Cadastrar novo galpão'
    expect(current_path).to eq new_user_session_path
  end

  it 'visitante não acessa diretamente o formulário' do
    visit new_warehouse_path

    expect(current_path).to eq new_user_session_path
  end

  it 'através de um link na tela inicial' do
    # Arrange
    User.create!(email: 'ruaaao@email.com', password: '12345678')
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'ruaaao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    click_on 'Cadastrar novo galpão'

    # Assert
    expect(page).to have_content 'Novo Galpão'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Código'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Área Total'
    expect(page).to have_field 'Área Útil'
    expect(page).to have_button 'Gravar'
  end

  it 'com sucesso' do
    # Arrange
    User.create!(email: 'ruaaao@email.com', password: '12345678')
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'ruaaao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    # Act
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: 'Juiz de Fora'
    fill_in 'Código', with: 'JDF'
    fill_in 'Endereço', with: 'Av Rio Branco'
    fill_in 'Cidade', with: 'Juiz de Fora'
    fill_in 'Estado', with: 'MG'
    fill_in 'CEP', with: '36000-000'
    fill_in 'Descrição', with: 'Um galpão mineiro com o pé no Rio'
    fill_in 'Área Total', with: '5000'
    fill_in 'Área Útil', with: '3000'
    click_on 'Gravar'
    # Assert
    expect(page).to have_content('Juiz de Fora')
    expect(page).to have_content('JDF')
    expect(page).to have_content('Um galpão mineiro com o pé no Rio')
    expect(page).to have_content('Av Rio Branco')
    expect(page).to have_content('Juiz de Fora/MG')
    expect(page).to have_content('CEP: 36000-000')
    expect(page).to have_content('Área Total: 5000 m2')
    expect(page).to have_content('Área Útil: 3000 m2')
    expect(page).to have_content 'Galpão registrado com sucesso'
  end

  it 'e todos campos são obrigatórios' do
    # Arrange
    User.create!(email: 'ruaaao@email.com', password: '12345678')
    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'ruaaao@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end
    # Act
    click_on 'Cadastrar novo galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'CEP', with: ''
    click_on 'Gravar'

    # Assert
    expect(page).not_to have_content 'Galpão registrado com sucesso'
    expect(page).to have_content 'Não foi possível gravar o galpão'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
  end
end
