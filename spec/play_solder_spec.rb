require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe PlaySolder::Fake, "for_path" do
  it "should return an image for jpgs" do
    PlaySolder::Fake.for_path("test.jpg").class.should == PlaySolder::Image
  end

  it "should return an image for pngs" do
    PlaySolder::Fake.for_path("test.png").class.should == PlaySolder::Image
  end

  it "should return an image for gifs" do
    PlaySolder::Fake.for_path("test.gif").class.should == PlaySolder::Image
  end

  it "should return an mp3 for mp3s" do
    PlaySolder::Fake.for_path("test.mp3").class.should == PlaySolder::MP3
  end

  it "should raise an error for other types" do
    lambda { PlaySolder::Fake.for_path("test.blah") }.should raise_error(PlaySolder::UnfakeablePathException)
  end
end

describe PlaySolder::Image do
  before(:all) do
    @file = PlaySolder::Image.new("A test file.jpg").generate
  end

  after(:all) do
    File.delete(@file) if @file
  end

  it "should create a file" do
    File.exist?(@file).should be_true
  end
end

describe PlaySolder::Image, "size" do
  before do
    PlaySolder::Image.auto_resize(/xxx/ => "1000x1000", "a string" => "500x500")
  end

  it "should return the correct size for filenames matching regexps" do
    PlaySolder::Image.new("/some/path/to/xxx.mp3").size.should == "1000x1000"
  end

  it "should return the correct size for paths matching regexps" do
    PlaySolder::Image.new("/some/path/to/xxx/test.mp3").size.should == "1000x1000"
  end

  it "should return the correct size paths matching a string" do
    PlaySolder::Image.new("/some/path/to/xxx/a string.mp3").size.should == "500x500"
  end

  it "should return the default size if no match" do
    PlaySolder::Image.new("/some/path/to/test.mp3").size.should == PlaySolder::Image::DEFAULT_SIZE
  end

end

describe PlaySolder::MP3 do
  before do
    @file = PlaySolder::MP3.new("A test mp3.mp3").generate
  end

  after(:all) do
    File.delete(@file) if @file
  end

  it "should create a file" do
    File.exist?(@file).should be_true
  end
end
