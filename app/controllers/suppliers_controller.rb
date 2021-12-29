class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit] 
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
    cnpj = params[:cnpj]
    supplier_params = params.require(:supplier).permit(:namesoc, :ficname, :address, :email, :cnpj, :tel)
    @supplier = Supplier.new(supplier_params)
       
    if @supplier.save()
      return redirect_to supplier_path(@supplier.id), notice: 'Fornecedor registrado com sucesso'
            
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
    if @supplier.save()
      return redirect_to supplier_path(@supplier.id), notice: 'Fornecedor editado com sucesso'
      redirect_to root_path
            
    else
    flash.now[:alert] = 'Não foi possível editar informações o fornecedor'
    render 'edit'
        
    end 
end
end