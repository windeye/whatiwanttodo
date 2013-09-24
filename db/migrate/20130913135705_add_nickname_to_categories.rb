class AddNicknameToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :nickname, :string
  end
end
