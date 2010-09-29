require "action_controller"

class PlaySolderController < ActionController::Base
  
  def show
    path = params[:path]
    ext = File.extname(path)
    
    if PlaySolder::Image.EXTENSIONS.include?(ext)
      image = PlaySolder::Image.new(path).generate
      send_file image.generate, :type => image.mime_type
    elsif PlaySolder::MP3.EXTENSIONS.include?(ext)
      mp3 = PlaySolder::MP3.new(path).generate
      send_file mp3.generate, :type => mp3.mime_type
    else
      raise UnfakeablePathException.new("Can't fake #{ path }")
    end
  end

end
