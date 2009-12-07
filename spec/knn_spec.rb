require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "KNN" do
  before do
    @knn = KNN.new(data)
  end
  
  it "should return 2 nearest neighbours (50,52 10,11)" do
    neighbours = @knn.nearest_neighbours([60,60], 2)
    neighbours.size.should == 2
    neighbours.map {|x| x[2]}.should include([50,52], [10,11])
  end
  
  private
  
  def data
    [[1,2], [5,6], [10,11], [50,52]]
  end
end
