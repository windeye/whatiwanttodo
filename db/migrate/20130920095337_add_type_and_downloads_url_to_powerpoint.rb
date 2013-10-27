class AddTypeAndDownloadsUrlToPowerpoint < ActiveRecord::Migration
  def change
		add_column :powerpoints, :download_url, :string
  end
end
