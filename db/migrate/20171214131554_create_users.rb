class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.float :gopay, null: false, default: 0
      t.string :license_plate
      t.float :rating, null: false, default: 5
      t.string :current_location

      t.timestamps
    end
  end
end
