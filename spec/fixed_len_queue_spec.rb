require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FixedLengthQueue" do
  before do
    @flpq = FixedLengthQueue.new(3)
  end

  describe "pushing elements more then queue limit is" do
    it "should return min priority element" do
      data.each{|a,b| @flpq.push(a,b)}
      expect(@flpq.next).to eq(9)
    end
  end

  private

  def data
    [[0, 10],
     [1, 5],
     [2, 33],
     [3, 70],
     [4, 37],
     [5, 91],
     [6, 35],
     [7, 65],
     [8, 17],
     [9, 8],
     [10, 21],
     [11, 8.1],
     [12, 20],
     [13, 97],
     [14, 84],
     [15, 80],
     [16, 0],
     [17, 88],
     [18, 24],
     [19, 70]]
  end
end
