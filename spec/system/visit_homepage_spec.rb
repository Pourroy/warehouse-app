require 'rails_helper'

describe 'Visitante abre a tela inicial' do
  # Cenários
  it 'e vê uma mensagem de boas vindas' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_css('h1', text: 'WareHouse App')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestão de estoques')
  end

  it 'e vê os galpões cadastrados' do
    # 3 As
    # Arrange => Preparar
    Warehouse.new(nome: 'Guarulhos', code: 'GRU', postal_code: '00000-000').save()
    Warehouse.new(nome: 'Porto Alegre', code: 'POA', postal_code: '00000-000').save()
    Warehouse.new(nome: 'São Luís', code: 'SLZ', postal_code: '00000-000').save()
    Warehouse.new(nome: 'Vitória', code: 'VIX', postal_code: '00000-000').save()
    # Act => Agir ou Executar
    visit root_path

    # Assert => Garantir ou validar ou checar
    expect(page).to have_content('Galpões Cadastrados')
    expect(page).to have_content('Guarulhos')
    expect(page).to have_content('GRU')
    expect(page).to have_content('Porto Alegre')
    expect(page).to have_content('POA')
    expect(page).to have_content('São Luís')
    expect(page).to have_content('SLZ')
    expect(page).to have_content('Vitória')
    expect(page).to have_content('VIX')
  end

  it 'e não vê todos detalhes do galpão' do
    # Arrange
    Warehouse.create(nome: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                     adress: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                     postal_code: '57050-000',
                     total_area: 10000, useful_area: 8000)

    # Act
    visit root_path

    # Assert
    expect(page).not_to have_content('Ótimo galpão numa linda cidade')
    expect(page).not_to have_content('Av Fernandes Lima')
    expect(page).not_to have_content('Maceió/AL')
    expect(page).not_to have_content('57050-000')
  end
end
