class AddImageToPowerpoint < ActiveRecord::Migration
  def change
    add_column :powerpoints, :image, :string
  end
end
