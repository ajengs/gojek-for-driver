class Api::V1::OrdersController < ApplicationController
  skip_before_action :authorize
  before_action :set_order, only: [:show, :update, :destroy]

  def update
    @order.update(order_params)
    header: :no_content
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status, :driver_id)
    end
end
