class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    @product_models = ProductModel.all
    render json: @product_models.as_json(except: %i[created_at updated_at
                                                    supplier_id category_id]),
                                                    status: 200
  end

  def show
    @product_model = ProductModel.find(params[:id])
    render json: @product_model.as_json(except: %i[created_at updated_at supplier_id category_id],
                                        methods: [:dimensions], include: { supplier:
                                      { except: %i[created_atr
                                                   updated_at] } }),
                                                   status: 200
  end

  def create
    paramters_product_model = params.permit(:name, :sku, :weight, :width, :length,
                                            :height, :supplier_id, :category_id)
    @product_model = ProductModel.new(paramters_product_model)
    if @product_model.save
      render json: @product_model, status: 201
    else
      render json: @product_model.errors.full_messages, status: 422
    end
  end
end
