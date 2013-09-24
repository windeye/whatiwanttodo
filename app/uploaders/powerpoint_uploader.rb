# encoding: utf-8

class PowerpointUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}"
  end

	def filename  
		Digest::SHA1.hexdigest(original_filename+Time.now.to_s) + File.extname(@filename) if @filename 
	end  
end
