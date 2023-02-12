require 'rails_helper'

describe 'User delete a category' do
  it 'succefully' do
    user = User.create!(email: 'ruaaao@email.com', password: '12345678')
    login_as(user)
    Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                      postal_code: '57050-000', address: 'Av Fernandes Lima',
                      city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)
    visit root_path
    visit root_path
    find('div#MCZ').click_on('Delete')

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão deletado com sucesso'
    expect(page).not_to have_content 'MCZ'
    expect(page).not_to have_link 'Maceió'
  end
end
