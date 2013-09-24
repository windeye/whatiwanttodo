class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :powerpoint_id

      t.timestamps
    end
    add_index :favourites, :user_id
    add_index :favourites, :powerpoint_id

		add_column :users, :favourites_count, :integer
		User.find_each do |user|
		  User.reset_counters(user.id, :favourites)
		end

		add_column :powerpoints, :favourites_count, :integer
		Powerpoint.find_each do |ppt|
		  Powerpoint.reset_counters(ppt.id, :favourites)
		end

  end
end
