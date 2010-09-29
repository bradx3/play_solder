require "pathname"

module PlaySolder
  class UnfakeablePathException < Exception; end  
  
  class Fake

    def self.for_path(path)
      ext = File.extname(path)
      
      if Image::EXTENSIONS.include?(ext)
        Image.new(path)
      elsif MP3::EXTENSIONS.include?(ext)
        MP3.new(path)
      else
        raise UnfakeablePathException.new("Can't fake #{ path }")
      end
    end

    attr_accessor :path
    
    def initialize(path)
      @path = path
    end

    def extension
      @extension = File.extname(path)
    end

    def text
      @text ||= File.basename(path).gsub(extension, "")
    end

    def faked_file
      if @faked_file.nil?
        @faked_file = "/tmp/#{ path }"
        parent = Pathname.new(@faked_file).parent.to_s
        FileUtils.mkdir_p(parent) unless File.exist?(parent)
      end
      @faked_file
    end

  end
end
