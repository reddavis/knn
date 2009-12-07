require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Array" do
  describe "Euclidean Distance" do
    it "should return 0" do
      [0,0].euclidean_distance_from([0,0]).should == 0
    end
    
    it "should return 1" do
      [0,0].euclidean_distance_from([0,1]).should == 1
    end
  end
end
