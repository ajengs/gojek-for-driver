class OrderDecorator < Draper::Decorator
  delegate_all

  def idr_price
    h.number_to_currency(price, unit: "Rp ", delimiter: ".", separator: ",")
  end

  def order_date
    created_at.strftime("%d %B %Y")
  end
end
