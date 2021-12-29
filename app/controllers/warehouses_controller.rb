class WarehousesController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit] 

  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end
  def new
    @warehouse = Warehouse.new

  end

  def create
    warehouse_params = params.require(:warehouse).permit(:nome, :code, :adress, :state, :city,
                                      :postal_code, :description, :useful_area,
                                      :total_area )
   @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
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
    @warehouse.update(params.require(:warehouse).permit(:nome, :code, :adress, :state, :city,
                                                        :postal_code, :description, :useful_area,
                                                        :total_area))
    if @warehouse.save()
      return redirect_to warehouse_path(@warehouse.id), notice: 'Galpão editado com sucesso'
      redirect_to root_path
            
    else
    flash.now[:alert] = 'Não foi possível editar informações do galpão'
    render 'edit'
        
    end 
  end
end
  