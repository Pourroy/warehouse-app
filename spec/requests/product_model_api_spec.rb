require 'rails_helper'

describe 'Product Models API' do
  context 'GET /api/v1/product_models' do
    it 'com sucesso' do
      c = Category.create!(name: 'Categoriatest')
      s = Supplier.create!(namesoc: 'Canecas Geek', ficname: 'Canekas Geek', cnpj: 'cnpjtestregit',
                           address: 'Rua deathdog', email: 'ruandogs@dogue.com', tel: '31980293233')
      pd = ProductModel.create(name: 'Caneca SW', height: '14', width: '8', length: '8',
                               weight: 300, supplier: s, category: c)
      get '/api/v1/product_models'

      expect(response).to have_http_status(200)
      expect(response.body).to include 'Caneca SW'
      expect(response.content_type).to include('application/json')
    end
    it 'empty response' do
      get '/api/v1/product_models'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end
  context 'GET /api/v1/suppliers/:id' do
    it 'com sucesso' do
      c = Category.create!(name: 'Categoriatest')
      s = Supplier.create!(namesoc:'Canecas Geek', ficname:'Canekas Geek', cnpj:'cnpjtestregit',
                           address:'Rua deathdog', email:'ruandogs@dogue.com', tel:'31980293233')
      pd = ProductModel.create(name:'Caneca SW', height:'14', width:'8', length:'8',
                               weight: 300, supplier: s, category: c)
      get("/api/v1/product_models/#{pd.id}")

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to eq 'Caneca SW'
      expect(parsed_response['height']).to eq 14
      expect(parsed_response['length']).to eq 8
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
      expect(parsed_response.keys).not_to include 'category_id'
      expect(parsed_response.keys).not_to include 'supplier_id'
    end
    it 'product model dont exist' do  
      get '/api/v1/product_models/999'

      expect(response.status).to eq 404
    end
  end
  context 'POST /api/v1/product_models' do
    it 'successfully' do
      # Arrange
      Category.create!(name: 'Categoriatest')
      Supplier.create!(namesoc: 'Ceramicas LTDA', ficname: 'Cerâmicas Geek', cnpj: 'ceramicageeek',
                       email: 'ceramicageek@ceramica.com', tel: '32980293232', address: 'Rua ceramica')
      # Act
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/product_models', params: '{ "name": "Galax S20",
                                                "weight": 15,
                                                "width": 15,
                                                "length": 15,
                                                "height": 300,
                                                "supplier_id": 1 ,
                                                "category_id": 1 }',
                                     headers: headers
      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to eq 'Galax S20'
      expect(parsed_response['weight']).to eq 15
      expect(parsed_response['width']).to eq 15
      expect(parsed_response['length']).to eq 15
      expect(parsed_response['height']).to eq 300
      expect(parsed_response['sku']).not_to eq nil
      expect(parsed_response['id']).to be_a_kind_of(Integer)
    end
    it 'has required fields empty' do
      # Arrange
      Category.create!(name:'Categoriatest')
      Supplier.create!(namesoc: 'Ceramicas LTDA', ficname: 'Cerâmicas Geek', cnpj: 'ceramicageeek',
                       address: 'Rua ceramica', email: 'ceramicageek@ceramica.com', tel: '32980293232')
      # Act
      headers = { 'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/product_models', params: '{"weight": 15,
                                               "width": 15,
                                               "length": 15,
                                               "height": 300,
                                               "supplier_id": 1 ,
                                               "category_id": 1 }',
                                    headers: headers
      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end
    it 'database error - 500' do
      # Arrange
      cat = Category.create!(name: 'Eletrônico')
      supplier = Supplier.create!(ficname: 'Samsung', namesoc: 'Samsung do BR LTDA',
                                  cnpj: '5935972000120', address: 'Av Industrial, 1000, São Paulo',
                                  email: 'financeiro@samsung.com.br', tel: '11 1234-5678')
      sw = ProductModel.create!(name: 'Caneca Star Wars', height: '14', width: '10', length: '8',
                                weight: 300, supplier: supplier, category:cat)
      allow(ProductModel).to receive(:find).with(sw.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
      # Act
      get("/api/v1/product_models/#{sw.id}")
      # Assert
      expect(response.status).to eq 500
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Não foi possível conectar ao banco de dados'
    end
  end
end
