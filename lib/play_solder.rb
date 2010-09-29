require "rubygems"
require "active_support"
require "actionpack"
require "play_solder/fake"
require "play_solder/image"
require "play_solder/mp3"

%w{ models controllers helpers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

module PlaySolder

end
