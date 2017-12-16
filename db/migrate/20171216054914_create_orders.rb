class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.bigint :external_id
      t.string :origin
      t.string :destination
      t.string :origin_coordinates
      t.string :destination_coordinates
      t.float :price
      t.references :user
      t.references :type

      t.timestamps
    end
  end
end
