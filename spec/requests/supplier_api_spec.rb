require 'rails_helper'

describe 'Suppliers API' do
  context 'GET /api/v1/suppliers' do
    it 'com sucesso' do
      Supplier.create!(namesoc: 'CLARO TELEFONIA', ficname: 'NET CLARO', cnpj: 'testcnpjgrava',
                       address: 'rua test', email: 'test@test.com', tel: '4002-8922')
      Supplier.create!(namesoc: 'VIVO TELEFONICA', ficname: 'VIVO', cnpj: 'tesxcnpjgravs',
                       address: 'rua testa', email: 'testinho@test.com', tel: '3002-8922')
      get '/api/v1/suppliers'
      expect(response).to have_http_status(200)
      expect(response.body).to include 'CLARO TELEFONIA'
      expect(response.body).to include 'VIVO TELEFONICA'
      expect(response.body).to include 'NET CLARO'
      expect(response.content_type).to include('application/json')
    end
    it 'empty response' do
      get '/api/v1/suppliers'

      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end
  context 'GET /api/v1/suppliers/:id' do
    it 'com sucesso' do
      supplier = Supplier.create!(namesoc: 'Claro Telefonia', ficname: 'Net Claro', cnpj: 'testcnpjgrava',
                                  address: 'rua test', email: 'test@test.com', tel: '4002-8922')
      get "/api/v1/suppliers/#{supplier.id}"
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response['namesoc']).to eq 'Claro Telefonia'
      expect(parsed_response['ficname']).to eq 'Net Claro'
      expect(parsed_response['address']).to eq 'rua test'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end
    it 'supplier dont exist' do
      get '/api/v1/suppliers/999'

      expect(response.status).to eq 404
    end
  end
  context 'POST /api/v1/suppliers' do
    it 'successfully' do
      headers = { 'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/suppliers', params: '{ "ficname": "Samsung",
                                            "namesoc": "SamsungSA",
                                            "cnpj": "0987654321098",
                                            "address": "Ruan Pinamba, 75",
                                            "email": "samsung@sam.com",
                                            "tel": "3030-4040"}',
                                headers: headers
      parsed_response = JSON.parse(response.body)

      expect(response.status).to eq 201
      expect(parsed_response['ficname']).to eq 'Samsung'
      expect(parsed_response['namesoc']).to eq 'SamsungSA'
      expect(parsed_response['cnpj']).to eq '0987654321098'
      expect(parsed_response['cnpj']).to eq '0987654321098'
      expect(parsed_response['id']).to be_a_kind_of(Integer)
    end
    it 'has required fields empty' do
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/suppliers', params: '{ "ficname": "Samsung",
                                            "address": "Ruan Pinamba, 75",
                                            "email": "samsung@sam.com",
                                            "tel": "3030-4040"}',
                                 headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Razão Social não pode ficar em branco'
      expect(response.body).to include 'Cnpj não pode ficar em branco'
    end
    it 'CNPJ is already registered' do
      # Arrange
      Supplier.create!(namesoc: 'CLARO TELEFONIA', ficname: 'NET CLARO', cnpj: 'testcnpjgrava',
                       address: 'rua test', email: 'test@test.com', tel: '4002-8922')
      # Act
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/suppliers', params: '{ "ficname": "Samsung",
                                            "namesoc": "SamsungSA",
                                            "cnpj": "testcnpjgrava",
                                            "address": "Ruan Pinamba, 75",
                                            "email": "samsung@sam.com",
                                            "tel": "3030-4040"}',
                                 headers: headers
      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Cnpj já está em uso'
    end
    it 'CNPJ is already registered' do
      # Arrange
      

      # Act
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/suppliers', params: '{ "ficname": "Samsung",
                                            "namesoc": "SamsungSA",
                                            "cnpj": "testcnpjgrav",
                                            "address": "Ruan Pinamba, 75",
                                            "email": "samsung@sam.com",
                                            "tel": "3030-4040"}',
                                 headers: headers
      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Cnpj não possui o tamanho esperado (13 caracteres)'
    end
    it 'database error - 500' do
      # Arrange
      supplier = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                  cnpj: '5935972000120', address: 'Av Industrial, 1000, São Paulo',
                                  email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
      allow(Supplier).to receive(:find).with(supplier.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
      # Act
      get("/api/v1/suppliers/#{supplier.id}")
      parsed_response = JSON.parse(response.body)
      # Assert
      expect(response.status).to eq 500
      expect(parsed_response['error']).to eq 'Não foi possível conectar ao banco de dados'
    end
  end
end
