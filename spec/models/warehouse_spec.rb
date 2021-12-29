require 'rails_helper'

RSpec.describe Warehouse, type: :model do
    
  it 'name é obrigatório' do
    # Arrange
    warehouse = Warehouse.new(nome: '', code: 'MCZ', 
                              description: 'Ótimo galpão mas é frio',
                              adress: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '45000-000',
                              total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse.valid?
    
    # Assert
    expect(result).to eq false
  end
    
  it 'postal_code é obrigatório' do
    warehouse = Warehouse.new(nome: 'Curitiba', code: 'MCZ', 
                              description: 'Ótimo galpão mas é frio',
                              adress: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '',
                              total_area: 5000, useful_area: 4000)
  # Act
    result = warehouse.valid?
    
    # Assert
    expect(result).to eq false

  end
    
  it 'código duplicado' do
    # Arrange
    warehouse = Warehouse.create(nome: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                                adress: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                                postal_code: '57050-000',
                                total_area: 10000, useful_area: 8000)
    
    warehouse2 = Warehouse.new(nome: 'Curitiba', code: 'MCZ', 
                              description: 'Ótimo galpão mas é frio',
                              adress: 'Av Coritiba', city: 'Curitiba', state: 'PR',
                              postal_code: '87050-000',
                              total_area: 5000, useful_area: 4000)
    # Act
    result = warehouse2.valid?
    
    # Assert
    expect(result).to eq false
    #expect(result).to be falsy
    #expect(warehouse2).not_to be_valid
  end
    
 context 'cep inválido não pode ser registrado' do
   it 'cep igual a 755' do
   # Arrange
     warehouse = Warehouse.new(nome: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                              adress: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                              postal_code: '755',
                              total_area: 10000, useful_area: 8000)
    
   # Act
    result = warehouse.valid?
    
   # Assert
    expect(result).to eq false
   end
    
  it 'cep igual a 700000-00' do
    # Arrange
    warehouse = Warehouse.new(nome: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                              adress: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                              postal_code: '700000-00',
                              total_area: 10000, useful_area: 8000)
    
    # Act
    result = warehouse.valid?
    
    # Assert
    expect(result).to eq false
  end
    
  it 'cep igual a aaaaa-aaa' do
   # Arrange
    warehouse = Warehouse.new(nome: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                              adress: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                              postal_code: 'aaaaa-aaa',
                              total_area: 10000, useful_area: 8000)
    
  # Act
    result = warehouse.valid?
    
  # Assert
    expect(result).to eq false
    
  end
 end
end
