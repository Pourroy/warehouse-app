require 'rails_helper'

RSpec.describe User, type: :model do
  it 'user creates a account' do
    usertest = User.new(email: 'raissinha@hotmail.com', password: '12345678')
    result = usertest.valid?
    expect(result).to eq true
  end
  it 'user email is unique' do
    User.create(email: 'raissinha@hotmail.com', password: '12345678')
    usertest = User.new(email: 'raissinha@hotmail.com', password: '12345678')
    result = usertest.valid?
    expect(result).to eq false
  end
  it 'user email cant be blank' do
    usertest = User.new(email: '', password: '12345678')
    result = usertest.valid?
    expect(result).to eq false
  end
  it 'password cant be blank' do
    usertest = User.new(email: 'raissinha@hotmail.com', password: '')
    result = usertest.valid?
    expect(result).to eq false
  end
  it ' password have size requirements' do
    usertest = User.new(email: 'raissinha@hotmail.com', password: '123')
    result = usertest.valid?
    expect(result).to eq false
  end
end
