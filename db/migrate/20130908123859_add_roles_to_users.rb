class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles, :integer, default: 0
		User.all.each do |u|
			u.roles = 0
		end
  end

end
