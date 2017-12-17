class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = @current_user.orders.all.decorate
  end

  def show
  end

  private
    def set_order
      @order = @current_user.orders.find(params[:id]).decorate
    end
    # def order_params
    #   params.require(:order).permit(:origin, :destination, :type_id, :payment_type, :status)
    # end
end
