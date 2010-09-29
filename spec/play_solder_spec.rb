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
