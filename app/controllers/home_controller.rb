class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:search]

  def index
    @warehouses = Warehouse.all
  end

  def search
    @waresearch = Warehouse.where('name like ? OR code like ?',
                                  "%#{params[:q]}%", "%#{params[:q]}%")
  end
end
