require "rails_helper"

describe 'Usuário registra um kit' do
  it 'visitante não vê o menu' do

    visit root_path

    expect(page).not_to have_link "Criar novo kit de produtos"
  end

  it 'visitante não acessa diretamente o formulário' do

    visit new_product_bundle_path

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do

    #arrange
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)

    c = Category.new(name: 'Categoriatest')

    s = Supplier.create!(namesoc:'Canecas Geek.', ficname:'Canekas Geek', cnpj:'cnpjtestregit',
                         address:'Rua deathdog', email:'ruandogs@dogue.com', tel:'31980293233')

    ProductModel.create!(name:'Caneca SW', height:'14', width:'8', length:'8', weight: 300, sku:'SWEASEKLA', supplier: s, category: c)

    ProductModel.create!(name:'Caneca BOSON DE HIGS', height:'12', width:'9', length:'9', weight: 350, sku:'SKj349asdj3@#$', supplier: s, category: c)

    ProductModel.create!(name:'Garrafa Térmica LHC', height:'20', width:'15', length:'15', weight: 500, sku:'SKj349asdj3@#1', supplier: s, category: c)

    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: 'Kit Par de Canecas'  
    check 'Caneca SW'
    check 'Caneca BOSON DE HIGS'
    click_on 'Gravar'

    expect(page).to have_content 'Kit Par de Canecas'
    expect(page).to have_content 'Caneca SW'
    expect(page).to have_content 'Caneca BOSON DE HIGS'
    expect(page).not_to have_content 'Garrafa Térmica LHC'
  
  end

  it 'nome é obrigatório' do
    user = User.create!(email: 'ruaao@email.com', password: '12345678')
    
    login_as(user, :scope => :user)

    c = Category.new(name: 'Categoriatest')

    s = Supplier.create!(namesoc:'Canecas Geek.', ficname:'Canekas Geek', cnpj:'cnpjtestregit',
                         address:'Rua deathdog', email:'ruandogs@dogue.com', tel:'31980293233')

    ProductModel.create!(name:'Caneca SW', height:'14', width:'8', length:'8', weight: 300, sku:'SWEASEKLA', supplier: s, category: c)

    ProductModel.create!(name:'Caneca BOSON DE HIGS', height:'12', width:'9', length:'9', weight: 350, sku:'SKj349asdj3@#$', supplier: s, category: c)

    ProductModel.create!(name:'Garrafa Térmica LHC', height:'20', width:'15', length:'15', weight: 500, sku:'SKj349asdj3@#1', supplier: s, category: c)

    visit root_path
    click_on 'Criar novo kit de produtos'
    fill_in 'Nome', with: ''  
    check 'Caneca SW'
    check 'Caneca BOSON DE HIGS'
    click_on 'Gravar'

    expect(page).not_to have_content 'KIT REGISTRADO COM SUCESSO'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end