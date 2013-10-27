class CreatePowerpoints < ActiveRecord::Migration
  def change
    create_table :powerpoints do |t|
      t.integer :user_id
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :powerpoints, :user_id
    add_index :powerpoints, :title,  :unique => true
  end
end
