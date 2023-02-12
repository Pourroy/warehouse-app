require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses' do
    it 'com sucesso' do
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceió', state: 'AL',
                        postal_code: '57050-000',
                        total_area: 10_000, useful_area: 8000)
      Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
                        address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
                        postal_code: '08050-000',
                        total_area: 20_000, useful_area: 18_000)
      get '/api/v1/warehouses'
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['name']).to eq 'Maceió'
      expect(parsed_response[1]['name']).to eq 'Guarulhos'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(response.body).not_to include 'Av do Aeroporto'
    end
    it 'empty response' do
      get '/api/v1/warehouses'

      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end
  context 'GET /api/v1/warehouses/:id' do
    it 'successfully' do
      warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', description: 'Galpão do Aeroporto Internacional',
                                    address: 'Av do Aeroporto', city: 'Guarulhos', state: 'SP',
                                    postal_code: '08050-000',
                                    total_area: 20_000, useful_area: 18_000)
      get "/api/v1/warehouses/#{warehouse.id}"
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response['name']).to eq 'Guarulhos'
      expect(parsed_response['code']).to eq 'GRU'
      expect(parsed_response['city']).to eq 'Guarulhos'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end
    it 'warehouse dont exist' do
      get "/api/v1/warehouses/999"

      expect(response.status).to eq 404
    end
  end
  context 'POST /api/v1/warehouses' do
    it 'successfully' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/warehouses', params: '{ "name": "Maceió",
                                            "code": "MCZ",
                                            "description": "Ótimo galpão numa linda cidade",
                                            "address": "Avenida dos Galpões, 1000",
                                            "city": "Maceió",
                                            "state": "AL",
                                            "postal_code": "57050-000",
                                            "total_area": 10000,
                                            "useful_area": 8000 }',
                                 headers: headers
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 201
      expect(parsed_response['name']).to eq 'Maceió'
      expect(parsed_response['code']).to eq 'MCZ'
      expect(parsed_response['id']).to be_a_kind_of(Integer)
    end
    it 'has required fields empty' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/warehouses', params: '{ "description": "Ótimo galpão numa linda cidade",
                                            "address": "Avenida dos Galpões, 1000",
                                            "city": "Maceió",
                                            "state": "AL",
                                            "postal_code": "57050-000",
                                            "total_area": 10000,
                                            "useful_area": 8000 }',
                                 headers: headers
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end
    it 'CODE is already registered' do
      # Arrange
      Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade',
                        postal_code: '57050-000', address: 'Av Fernandes Lima',
                        city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)
      # Act
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/warehouses', params: '{ "name": "Rio de Janeiro",
                                            "code": "MCZ",
                                            "description": "Ótimo galpão numa linda cidade",
                                            "address": "Avenida dos Galpões, 1000",
                                            "city": "Rio de Janeiro",
                                            "state": "RJ",
                                            "postal_code": "57050-000",
                                            "total_area": 10000,
                                            "useful_area": 8000 }',
                                 headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Código já está em uso'
    end
    it 'postal_code format invalid' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/warehouses', params: '{ "name": "Rio de Janeiro",
                                            "code": "MCZ",
                                            "description": "Ótimo galpão numa linda cidade",
                                            "address": "Avenida dos Galpões, 1000",
                                            "city": "Rio de Janeiro",
                                            "state": "RJ",
                                            "postal_code": "57005000",
                                            "total_area": 10000,
                                            "useful_area": 8000 }',
                                 headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'CEP não é válido'
    end
    it 'database error - 500' do
      # Arrange
      w = Warehouse.create!(name: 'Maceió', code: 'MCZ', description: 'Ótimo galpão numa linda cidade', 
                            postal_code: '57050-000', address: 'Av Fernandes Lima', 
                            city: 'Maceió', state: 'AL', total_area: 10_000, useful_area: 8000)
      allow(Warehouse).to receive(:find).with(w.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
      # Act
      get("/api/v1/warehouses/#{w.id}")

      # Assert
      expect(response.status).to eq 500
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Não foi possível conectar ao banco de dados'
    end
  end
end
