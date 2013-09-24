class AddTypeAndDownloadsUrlToPowerpoint < ActiveRecord::Migration
  def change
		add_column :powerpoints, :download_url, :string
    add_column :powerpoints, :powerpoint_type, :string
  end
end
