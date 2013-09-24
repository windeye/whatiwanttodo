class ChangeTermsOfServiceFieldForUsers < ActiveRecord::Migration
  def up
		change_column :users, :terms_of_service, :integer
  end
  def down
		change_column :users, :terms_of_service, :string
  end
end
