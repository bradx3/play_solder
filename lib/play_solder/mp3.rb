module PlaySolder
  class MP3 < Fake

    def generate
      aiff = faked_file.gsub(extension, ".aiff")
      cmd = %Q{ say -v Vicki "#{ text }" -o "#{ aiff }"; }
      cmd += %Q{ sox "#{ aiff }" "#{ faked_file }"; }
      system(cmd)
      faked_file
    end

  end
end
