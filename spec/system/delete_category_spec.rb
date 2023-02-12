require 'rails_helper'

describe 'User delete a category' do
  it 'succefully' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Category.create!(name: 'Categoriatest')
    visit root_path
    click_on 'Ver categorias de produtos'
    click_on 'Delete'

    expect(current_path).to eq categories_path
    expect(page).to have_content 'Categoria deletada com sucesso'
    expect(page).not_to have_content 'Categoriatest'
  end
end
