require File.expand_path(File.dirname(__FILE__) + '/../lib/knn')
require 'benchmark'

data = Array.new(10000) { Array.new(4) { rand } }

knn = KNN.new(data)

Benchmark.bm do |x|
  x.report { puts knn.nearest_neighbours([3,4,5,6], 4).inspect }
end