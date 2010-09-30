module PlaySolder
  class Image < Fake
    EXTENSIONS = [ ".jpg", ".png", ".gif" ]
    DEFAULT_SIZE = "200x100"

    def self.auto_resize(options)
      @@auto_resize = options
    end

    def generate
      return faked_file if File.exist?(faked_file)

      cmd = "convert"
      cmd += " -background \\#{ random_colour }"
      cmd += " -size #{ size }"
      cmd += " -gravity center"
      cmd += " label:\"#{ text }\""
      cmd += " \"#{ escaped_faked_file }\""
      system(cmd)
      faked_file
    end

    def mime_type
      if extension == ".jpg"
        "image/jpeg"
      elsif extension == ".png"
        "image/png"
      elsif extension == ".gif"
        "image/gif"
      end
    end

    def size
      if defined?(@@auto_resize) and @@auto_resize
        @@auto_resize.each do |regexp, size|
          return size if path.match(regexp)
        end
      end
      DEFAULT_SIZE
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
end
