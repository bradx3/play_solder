require "pathname"

module PlaySolder
  
  class PlaySolder::Fake
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

  class PlaySolder::Image < PlaySolder::Fake
    def generate
      cmd = "convert -background \\#{ random_colour }"
      cmd += " -size 200x100 -gravity center"
      cmd += %Q{ label:"#{ text }" }
      cmd += %Q{ "#{ faked_file }" }
      system(cmd)
      faked_file
    end

    def random_colour
      comps = []
      6.times { comps << random_component }
      "##{ comps.join }"
    end

    def random_component
      (3..13).sort_by { rand }.first.to_s(16)
    end

  end


  class PlaySolder::MP3 < PlaySolder::Fake
    def generate
      aiff = faked_file.gsub(extension, ".aiff")
      cmd = %Q{ say -v Vicki "#{ text }" -o "#{ aiff }"; }
      cmd += %Q{ sox "#{ aiff }" "#{ faked_file }"; }
      system(cmd)
      faked_file
    end
  end

end
