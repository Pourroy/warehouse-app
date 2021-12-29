class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  def show
    id = params[:id]
    @product_bundle = ProductBundle.find(id)
  end
  def new
    @product_bundle =  ProductBundle.new
  end
 
  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])
    @product_bundle = ProductBundle.new(bundle_params)
    if @product_bundle.save
      redirect_to product_bundle_path(@product_bundle.id), notice: "KIT REGISTRADO COM SUCESSO"
    else
      flash.now[:alert] = "Não foi possível registar seu kit"
      render 'new'
    end
  end
end
