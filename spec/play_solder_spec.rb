require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PlaySolder::Image do
  before do
    @image = PlaySolder::Image.new("Yyyy.jpg")
  end

  it "should generate" do
    @image.generate
  end
end

describe PlaySolder::MP3 do
  before do
    @audio = PlaySolder::MP3.new("xxx.mp3")
  end

  it "should generate" do
    @audio.generate
  end
end
