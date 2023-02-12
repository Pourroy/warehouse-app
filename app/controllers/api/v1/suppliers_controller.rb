class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    @suppliers = Supplier.all
    render json: @suppliers.as_json(except: %i[created_at updated_at]), status: 200
  end

  def show
    @supplier = Supplier.find(params[:id])
    render json: @supplier.as_json(except: %i[created_at updated_at]), status: 200
  end

  def create
    paramters_supplier = params.permit(:namesoc, :ficname, :address, :email, :cnpj, :tel)
    @supplier = Supplier.new(paramters_supplier)
    if @supplier.save
      render json: @supplier, status: 201
    else
      render json: @supplier.errors.full_messages, status: 422
    end
  end
end
