class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    orders = @current_user.orders.all.paginate(page: params[:page], per_page: 10)
    @orders = OrderDecorator.decorate_collection(orders)
  end

  def show
  end

  private
    def set_order
      @order = @current_user.orders.find(params[:id]).decorate
    end
end
