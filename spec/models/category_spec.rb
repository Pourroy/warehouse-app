require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'name cant be blank' do
    # Arrange
    category = Category.new(name: '')
    # Act
    result = category.valid?
    # Assert
    expect(result).to eq false
  end
  it 'name is uniq' do
    # Arrange
    Category.create!(name: 'Roupa íntima')
    category = Category.new(name: 'Roupa íntima')
    # Act
    result = category.valid?
    # Assert
    expect(result).to eq false
  end
end
