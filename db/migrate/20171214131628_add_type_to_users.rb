class AddTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :type, foreign_key: true
  end
end
