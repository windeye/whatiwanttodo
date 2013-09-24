# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [220, 124]
  end

  version :medium do
    process :resize_to_fit => [476, 268]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

	def filename  
		Digest::SHA1.hexdigest(original_filename+Time.now.to_s) + File.extname(@filename) if @filename 
	end  
end
