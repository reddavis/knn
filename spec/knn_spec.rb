require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include KNN_MODULE

describe "KNN" do
  before do
    @knn = KNN.new(data)
    @knn_2 = KNN.new(data_block){|x,y| (x.size - y.size).abs}
    proc = Proc.new{ |x,y| (x.size - y.size).abs }
    @knn_3 = KNN.new(data_block){|x, y| proc.call(x,y)}
  end

  it "should return 2 nearest neighbours (50,52 10,11)" do
    neighbours = @knn.nearest_neighbours([60,60], 2)
    neighbours.size.should == 2
    neighbours.map {|x| x[2]}.should include([50,52], [10,11])
  end

  it "should return 2 nearest neighbours size of 3 and 5" do
    neighbours_2 = @knn_2.nearest_neighbours([1,2,3,4], 2)
    neighbours_2.size.should == 2
    neighbours_2.map {|x| x[2]}.should include([1,1,1,1,1], [1,1,1])
  end

  it "should return 2 nearest neighbours size of 3 and 5" do
    neighbours_3 = @knn_3.nearest_neighbours([1,2,3,4], 2)
    neighbours_3.size.should == 2
    neighbours_3.map {|x| x[2]}.should include([1,1,1,1,1], [1,1,1])
  end

  describe "Providing a wrong distance measure" do
    it "should raise an error" do
      lambda do
        KNN.new(data, :distance_measure => :wrong).nearest_neighbours([2,2])
      end.should raise_error
    end
  end

  private

  def data
    [[1,2], [5,6], [10,11], [50,52]]
  end

  def data_block
    [[1,1,1,1,1], [1,1,1], [3,3], [1,2,23,1,1,2,1]]
  end
end
