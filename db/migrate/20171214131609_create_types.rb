class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string :name
      t.float :base_fare

      t.timestamps
    end
  end
end
