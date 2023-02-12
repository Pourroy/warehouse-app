class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit product_entry destroy]
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
    @product_models = ProductModel.where(category: @warehouse.categories)
  end

  def new
    @warehouse = Warehouse.new
  end

  def product_entry
    @warehouse = Warehouse.find(params[:id])
    pe = ProductEntry.new(quantity: params[:quantity], warehouse_id: params[:id],
                          product_model_id: params[:product_model_id])
    if pe.process
      redirect_to @warehouse
    else
      message = 'Produto não disponível, consulte o status do produto'
      redirect_to @warehouse, notice: message
    end
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address, :state, :city,
                                                         :postal_code, :description, :useful_area,
                                                         :total_area, category_ids: [])
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível gravar o galpão'
      render 'new'
    end
  end

  def edit
    @warehouse = Warehouse.find(params[:id])
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    @warehouse.update(params.require(:warehouse).permit(:name, :code, :address, :state, :city,
                                                        :postal_code, :description, :useful_area,
                                                        :total_area, category_ids: []))
    if @warehouse.errors.any?
      render :edit
    else
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão editado com sucesso'
    end
  end

  def destroy
    @warehouse = Warehouse.find(params[:id])
    @warehouse.delete
    redirect_to root_path, notice: 'Galpão deletado com sucesso'
  end
end
