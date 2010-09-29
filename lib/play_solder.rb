require "rubygems"
require "mini_magick"
require "pathname"

module PlaySolder
  
  class PlaySolder::Fake
    attr_accessor :path
    
    def initialize(path)
      @path = path
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

  class PlaySolder::Image < PlaySolder::Fake
    def generate
      image = MiniMagick::Image.new(path)
      image.background(random_colour)
      image.write(faked_file)
      faked_file
    end

    def random_colour
      comps = []
      6.times { comps << random_component }
      "##{ comps.join }"
    end

    def random_component
      rand(15).to_s(16)
    end

  end


  class PlaySolder::MP3 < PlaySolder::Fake
    def generate
      ext = File.extname(path)
      message = File.basename(path).gsub(ext, "")
      aiff = faked_file.gsub(ext, ".aiff")
      cmd = %Q{ say -v Vicki "#{ message }" -o "#{ aiff }"; }
      cmd += %Q{ sox "#{ aiff }" #{ faked_file }"; }
      system(cmd)
      faked_file
    end
  end

end
