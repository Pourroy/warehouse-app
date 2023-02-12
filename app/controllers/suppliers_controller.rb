class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit destroy index show]

  def index
    @suppliers = Supplier.all
    render 'index'
  end

  def new
    @supplier = Supplier.new
  end

  def show
    id = params[:id]
    @supplier = Supplier.find(id)
  end

  def create
    supplier_params = params.require(:supplier).permit(:namesoc, :ficname, :address, :email, :cnpj, :tel)
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      redirect_to supplier_path(@supplier.id), notice: 'Fornecedor registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar o fornecedor'
      render 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    @supplier.update(params.require(:supplier).permit(:namesoc, :ficname, :address, :email, :cnpj, :tel))
    if @supplier.save
      redirect_to supplier_path(@supplier.id), notice: 'Fornecedor editado com sucesso'
    else
      render 'edit'
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.delete
    redirect_to suppliers_path, notice: 'Fornecedor deletado com sucesso'
  end
end
