class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
  end
	add_column :powerpoints, :category_id, :integer
	add_index :powerpoints, :category_id
end
