require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PlaySolder::Image do
  before(:all) do
    @file = PlaySolder::Image.new("A test file.jpg").generate
  end

  after(:all) do
    File.delete(@file)
  end

  it "should create a file" do
    File.exist?(@file).should be_true
  end
  
end

describe PlaySolder::MP3 do
  before do
    @file = PlaySolder::MP3.new("A test mp3.mp3").generate
  end

  it "should create a file" do
    File.exist?(@file).should be_true
  end
end
