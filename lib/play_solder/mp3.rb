module PlaySolder
  class MP3 < Fake
    EXTENSIONS = [ ".jpg", ".png" ]

    def generate
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
