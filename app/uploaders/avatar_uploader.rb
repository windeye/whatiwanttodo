# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

	def default_url
		"default-avatar.jpg"
	end
  version :thumb do
    process :resize_to_fit => [64, 64]
  end

  version :medium do
    process :resize_to_fit => [256, 256]
  end

	def extension_white_list
		%w(jpg jpeg gif png)
	end

	def filename  
		Digest::SHA1.hexdigest(original_filename) + File.extname(@filename) if @filename 
	end  
end
