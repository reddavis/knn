require File.expand_path(File.dirname(__FILE__) + '/ext/array')

class KNN
  def initialize(data)
    @data = data
  end
  
  def nearest_neighbours(input, k=4)
    find_closest_data(input, k)
  end
  
  private
  
  def find_closest_data(input, k)
    calculated_distances = []
    
    @data.each_with_index do |datum, index| #Ye olde english
      distance = input.euclidean_distance_from(datum)
      calculated_distances << [index, distance, datum]
    end
    
    calculated_distances.sort {|x, y| x[1] <=> y[1]}.first(k)
  end  
end