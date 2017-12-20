class OrderRelayJob < ApplicationJob
  def perform(order)
    # ActionCable.server.broadcast "messages:#{comment.message_id}:comments",
    # ActionCable.server.broadcast "orders",
    #   order: OrdersController.render(partial: 'orders/order', locals: { order: order.decorate })

    ActionCable.server.broadcast 'orders', OrdersController.render(partial: 'orders/order', locals: { order: order.decorate })
  end
end