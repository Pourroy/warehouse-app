class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new_entry]

  def new_entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.in
  end

  def process_entry
    @product_entry = ProductEntry.new(quantity: params[:quantity], product_model_id: params[:product_model_id],
                                      warehouse_id: params[:warehouse_id])
    if @product_entry.process
      redirect_to warehouse_path(@product_entry.warehouse_id), notice: 'PRODUTOS SALVOS COM SUCESSO EM SEU GALPÃO'
    else
      redirect_to product_items_entry_path, alert: 'CATEGORIA DO PRODUTO INCOMPATÍVEL COM O GAPÃO'
    end
  end
end
