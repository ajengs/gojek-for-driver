class AddPaymentTypeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payment_type, :string
  end
end
