module PlaySolder
  class Swf < Fake
    EXTENSIONS = [ ".swf" ]
    
    def generate
      return faked_file if File.exist?(faked_file)
      FileUtils.copy('placeholder.swf', "/tmp/play_solder/#{path}")
      faked_file
    end

    def mime_type
      "application/x-shockwave-flash"
    end
  end
end