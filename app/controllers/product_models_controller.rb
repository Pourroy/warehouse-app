require 'securerandom'
class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit index destroy in out]

  def index
    @product_models = ProductModel.all
    render 'index'
  end

  def new
    @product_model = ProductModel.new
  end

  def show
    id = params[:id]
    @product_model = ProductModel.find(id)
    @product_models = ProductModel.all
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :sku, :weight, :width, :length, :height,
                                                                 :supplier_id, :category_id, :status)
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to product_model_path(@product_model.id), notice: 'Modelo de produto registrado com sucesso'
    else
      render 'new'
    end
  end

  def edit
    @product_model = ProductModel.find(params[:id])
  end

  def update
    @product_model = ProductModel.find(params[:id])
    @product_model.update(params.require(:product_model).permit(:name, :sku, :weight, :width, :length, :height,
                                                                :supplier_id, :category_id, :status))
    if @product_model.save
      redirect_to product_model_path(@product_model.id), notice: 'Produto editado com sucesso'
    else
      render 'edit'
    end
  end

  def destroy
    @product_model = ProductModel.find(params[:id])
    @product_model.delete
    redirect_to root_path, notice: 'Modelo de produto deletado com sucesso'
  end

  def in
    @product_model = ProductModel.find(params[:id])
    @product_model.in!
    redirect_to @product_model, notice: 'Edição efetuada com sucesso'
  end

  def out
    @product_model = ProductModel.find(params[:id])
    @product_model.out!
    redirect_to @product_model, notice: 'Edição efetuada com sucesso'
  end
end
