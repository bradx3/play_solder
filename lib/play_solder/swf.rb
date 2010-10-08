module PlaySolder
  class Swf < Fake
    EXTENSIONS = [ ".swf" ]
    
    def generate
      return faked_file if File.exist?(faked_file)
      swf = File.join(File.dirname(__FILE__), "..", "..", "placeholder.swf")
      FileUtils.copy(swf, faked_file)
      faked_file
    end

    def mime_type
      "application/x-shockwave-flash"
    end
  end
end
