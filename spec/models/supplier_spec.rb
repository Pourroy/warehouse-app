require 'rails_helper'

RSpec.describe Supplier, type: :model do
  it 'Razão Social can not to be blank ' do
    supplier = Supplier.new(namesoc: '', ficname: 'NET CLARO', cnpj: 'testcnpjgrava',
                            address: 'rua test', email: 'test@test.com', tel: '4002-8922')
    result = supplier.valid?

    expect(result).to eq false
  end
  it 'CNPJ can not to be blank ' do
    # Arrange
    supplier = Supplier.new(namesoc: 'Claro Net', ficname: 'NET CLARO', cnpj: '', address: 'rua test',
                            email: 'test@test.com', tel: '4002-8922')
    # Act
    result = supplier.valid?
    # assert
    expect(result).to eq false
  end
  it 'CNPJ needs have size 13 ' do
    # Arrange
    supplier = Supplier.new(namesoc: 'Claro Net', ficname: 'NET CLARO', cnpj: 'testcnpjgrav',
                            address: 'rua test', email: 'test@test.com', tel: '4002-8922')
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end
  it 'Nome Fantasia can not to be blank ' do
    # Arrange
    supplier = Supplier.new(namesoc: 'Claro Net', ficname: '', cnpj: 'testcnpjgrava',
                            address: 'rua test', email: 'test@test.com', tel: '4002-8922')
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end
  it 'E-mail can not to be blank ' do
    # Arrange
    supplier = Supplier.new(namesoc: 'Claro Net', ficname: 'NET CLARO', cnpj: 'testcnpjgrava',
                            address: 'rua test', email: '', tel: '4002-8922')
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end
  it 'CNPJ is uniq ' do
    # Arrange
    Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                     address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
    supplier = Supplier.new(namesoc: 'Claro Net', ficname: 'NET CLARO', cnpj: 'cnpjtestregit',
                            address: 'rua test', email: 'test@test.com', tel: '4002-8922')
    # Act
    result = supplier.valid?
    # Assert
    expect(result).to eq false
  end
end
