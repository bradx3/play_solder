module PlaySolder
  class MP3 < Fake
    EXTENSIONS = [ ".mp3" ]

    def generate
      return faked_file if File.exist?(faked_file)

      aiff = faked_file.gsub(extension, ".aiff")
      cmd = %Q{ say -v Vicki "#{ text }" -o "#{ aiff }"; }
      cmd += %Q{ sox "#{ aiff }" "#{ faked_file }"; }
      system(cmd)
      faked_file
    end

    def mime_type
      "application/mp3"
    end

  end
end
