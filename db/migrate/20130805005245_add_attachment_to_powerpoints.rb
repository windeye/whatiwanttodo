class AddAttachmentToPowerpoints < ActiveRecord::Migration
  def change
    add_column :powerpoints, :attachment, :string
    add_column :powerpoints, :file_name,  :string
    add_column :powerpoints, :file_size,  :integer
  end
end
