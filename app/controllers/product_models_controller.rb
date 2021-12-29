require 'securerandom'
class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit] 
  def new
    @product_model = ProductModel.new
  end

  def show
    id = params[:id]
    @product_model = ProductModel.find(id)
  end

  
  def create
    product_model_params = params.require(:product_model).permit(:name, :sku, :weight, :width,
                                                                 :length, :height, :supplier_id, :category_id)
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save()
        redirect_to product_model_path(@product_model.id), notice: 'Modelo de produto registrado com sucesso'
      else
        flash.now[:alert] = 'Não foi possível registrar o modelo de produto'
        render 'new'
    end
  end

  def edit
    @product_model = ProductModel.find(params[:id])
  end

  def update
    @product_model = ProductModel.find(params[:id])
    @product_model.update(params.require(:product_model).permit(:name, :sku, :weight, :width,
                                                                :length, :height, :supplier_id, :category_id))
    if @product_model.save()
      return redirect_to product_model_path(@product_model.id), notice: 'Produto editado com sucesso'
      redirect_to root_path
            
    else
    flash.now[:alert] = 'Não foi possível editar informações do modelo do produto'
    render 'edit'    
    end 
  end
end