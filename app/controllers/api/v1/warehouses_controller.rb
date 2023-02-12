class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    @warehouses = Warehouse.all
    render json: @warehouses.as_json(except: %i[address created_at updated_at]), status: 200
  end

  def show
    @warehouse = Warehouse.find(params[:id])
    render json: @warehouse.as_json(except: %i[created_at updated_at]), status: 200
  end

  def create
    paramters_w = params.permit(:name, :code, :address, :state, :city,
                                :postal_code, :description, :useful_area,
                                :total_area, category_ids: [])
    @warehouse = Warehouse.new(paramters_w)
    if @warehouse.save
      render json: @warehouse, status: 201
    else
      render json: @warehouse.errors.full_messages, status: 422
    end
  end
end
