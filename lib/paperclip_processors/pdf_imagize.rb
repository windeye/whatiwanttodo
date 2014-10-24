require "paperclip"
module Paperclip
    class PdfImagize < Processor
    
    attr_accessor :file, :params, :format
    
    def initialize file, options = {}, attachment = nil
      super
      @file           = file
      @params         = options[:params]
      #文件的扩展名
      @current_format = File.extname(@file.path)
      #文件名，不包含扩展名(因为有第二个参数，否则会包含扩展名)
      @basename       = File.basename(@file.path, @current_format)
      @format         = options[:format]
    end

    def make
      #src = @file
      #dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      src_path = File.expand_path(@file.path) if @file
      digest = Digest::SHA1.hexdigest(@file.original_filename.delete("_ "))
      dest_dir  = "/home/deploy/data/slides/" + digest
      dest = dest_dir + "/%d.png"
      begin
        parameters = []
        parameters << @params
        parameters << "-o :dest"
        parameters << ":source"
        
        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")
      
        #success = Paperclip.run("mkdir", "-p #{dest_dir}")
        FileUtils.mkdir_p(dest_dir)
        success = Paperclip.run("mudraw", parameters, :source => src_path,:dest => dest)
      rescue Cocaine::CommandLineError => e
        raise PaperclipError, "There was an error converting #{@basename} to images"
      end
      dst = Tempfile.new([digest, ".png"],:encoding => 'ascii-8bit')
      dst_path = File.expand_path(dst.path)
      src_thumb = dest_dir+"/1.png"
      #dst_thumb = dest_dir+"/thumb.jpg"

      begin
        params = []
        params << ":source"
        params << "-resize 320x240"
        params << ":dest"
        
        params = params.flatten.compact.join(" ").strip.squeeze(" ")

        success = convert(params, :source => src_thumb,:dest => (dst_path))
        #FileUtils.cp(dst_path, dst_thumb)
      rescue Cocaine::CommandLineError => e
        raise PaperclipError, "There was an error processing the thumbnail for #{@basename}"
      end
      dst
    end
    
  end
end
