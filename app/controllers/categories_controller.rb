class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :index, :show]
  def index
    @categories = Category.all
    render 'index'
  end

  def show
    id = params[:id]
    @category = Category.find(id)
  end

  def new
    @category = Category.new
  end

  def create
    category_params = params.require(:category).permit(:name)
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: 'Categoria registrada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar a categoria desejada'
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.delete
    redirect_to categories_path, notice: 'Categoria deletada com sucesso'
  end
end
