class AddPdffileColumnsToPowerpoints < ActiveRecord::Migration
  def change
    add_attachment :powerpoints, :pdffile
    add_column :powerpoints, :file_id, :string
    add_column :powerpoints, :page_count, :integer, default: 0
		add_index :powerpoints, :file_id,  :unique => true
  end
end
