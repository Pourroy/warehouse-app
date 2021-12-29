require 'rails_helper'

describe 'Visitante cadastra um fornecedor' do
  it 'visitante não vê o menu' do

    visit root_path

    expect(page).not_to have_link "Cadastrar novo fornecedor"
  end

  it 'visitante não acessa diretamente o formulário' do

    visit new_supplier_path

    expect(current_path).to eq new_user_session_path
  end


  it 'através de um link na tela inicial' do
    # Arrange
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)

    # Act
    visit root_path
    click_on 'Cadastrar novo fornecedor'

    # Assert
    expect(page).to have_content 'Novo fornecedor'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Telefone'
    
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)
    # Act
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão Social', with: 'Ruan Hotdog ltda.'
    fill_in 'Nome Fantasia', with: 'Dogão do Ruão'
    fill_in 'CNPJ', with: '1212121212126'
    fill_in 'Endereço', with: 'Rua deathdog'
    fill_in 'Email', with: 'ruandogs@dog.com'
    fill_in 'Telefone', with: '31980293232'
    click_on 'Gravar'

    # Assert    
    expect(page).to have_content('Ruan Hotdog ltda.')
    expect(page).to have_content('Dogão do Ruão')
    expect(page).to have_content('CNPJ: 1212121212126')
    expect(page).to have_content('Endereço: Rua deathdog')
    expect(page).to have_content('Email: ruandogs@dog.com')
    expect(page).to have_content('Telefone: 31980293232')
    expect(page).to have_content('Fornecedor registrado com sucesso')
  end

  it 'testando CPNJ com número de dígitos diferente de 13' do
    # Arrange
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)
    # Act
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão Social', with: 'RuanBurger'
    fill_in 'Nome Fantasia', with: 'Ruan s/a'
    fill_in 'CNPJ', with: '123'
    fill_in 'Email', with: 'ruan_22@teste.com'
    click_on 'Gravar'

    # Assert
    expect(page).not_to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content 'Não foi possível registrar o fornecedor'
    expect(page).to have_content "Verifique os campos abaixo:"
    expect(page).to have_content 'Cnpj não possui o tamanho esperado (13 caracteres)'
  end

  it 'Verificando se campos são obrigatórios' do

    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Email', with: ''
    click_on 'Gravar'

    expect(page).not_to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content "Verifique os campos abaixo:"
    expect(page).to have_content 'Não foi possível registrar o fornecedor'
    expect(page).to have_content "Razão Social não pode ficar em branco"
    expect(page).to have_content "Nome Fantasia não pode ficar em branco"
    expect(page).to have_content "Cnpj não pode ficar em branco"
    expect(page).to have_content "Email não pode ficar em branco"
    expect(page).to have_content "Cnpj não possui o tamanho esperado (13 caracteres)"
  end
  it 'Usuário tenta cadastrar um Cnpj já cadastrado no banco' do
   
    #arrange
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)
    Supplier.create(namesoc:'Ruan Hotdog ltda.', ficname:'Dogão do Ruão', cnpj:'cnpjtestregis', address:'Rua deathdog', email:'ruandogs@dog.com', tel:'31980293232')

    
    #act
    visit root_path
    click_on 'Cadastrar novo fornecedor'
    fill_in 'Razão Social', with: 'Ruan Hotdog ltda.'
    fill_in 'Nome Fantasia', with: 'Dogão do Ruão'
    fill_in 'CNPJ', with: 'cnpjtestregis'
    fill_in 'Endereço', with: 'Rua deathdog'
    fill_in 'Email', with: 'ruandogs@dog.com'
    fill_in 'Telefone', with: '31980293232'
    click_on 'Gravar'
    
    expect(page).not_to have_content 'Fornecedor registrado com sucesso'
    expect(page).to have_content 'Não foi possível registrar o fornecedor'
    expect(page).to have_content "Verifique os campos abaixo:"
    expect(page).to have_content 'Cnpj já está em uso'
    end
    it 'Verificando se mensagens aparecem isoladas' do

      user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
     login_as(user, :scope => :user)

      visit root_path
      click_on 'Cadastrar novo fornecedor'
      fill_in 'Razão Social', with: 'test'
      fill_in 'Nome Fantasia', with: ''
      fill_in 'CNPJ', with: 'cnpjtestgrava'
      fill_in 'Email', with: ''
      click_on 'Gravar'
  
      expect(page).not_to have_content 'Fornecedor registrado com sucesso'
      expect(page).to have_content "Verifique os campos abaixo:"
      expect(page).to have_content 'Não foi possível registrar o fornecedor'
      expect(page).to have_content "Nome Fantasia não pode ficar em branco"
      expect(page).to have_content "Email não pode ficar em branco"
    end
end