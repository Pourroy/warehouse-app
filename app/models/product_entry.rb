class ProductEntry
  attr_accessor :quantity, :product_model_id, :warehouse_id

  def initialize(quantity:, product_model_id:, warehouse_id:)
    @quantity = quantity.to_i
    @product_model_id = product_model_id
    @warehouse_id = warehouse_id
  end

  def process
    return false unless valid?

    @w = Warehouse.find(warehouse_id)
    @pm = ProductModel.find(product_model_id)

    ProductItem.transaction do
      @quantity.times do
        ProductItem.create!(warehouse: @w, product_model: @pm)
      end
    end
  end

  private

  def valid?
    @w = Warehouse.find(@warehouse_id)
    @pm = ProductModel.find(@product_model_id)
    if @pm.in?
      @w.categories.include? @pm.category
    else
      false
    end
  end
end
