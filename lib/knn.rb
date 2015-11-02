require 'distance_measures'
require_relative 'fixed_queue'

class KNN
  def initialize(data, options={})
    @data = data
    @distance_measure = options[:distance_measure] || :euclidean_distance
  end
  
  def nearest_neighbours(input, k=4)
    find_closest_data(input, k)
  end
  
  private
  
  def find_closest_data(input, k)

    pq = FixedLengthQueue.new(k)
    begin
      calculated_distances = []
    
      @data.each_with_index do |datum, index| #Ye olde english
        distance = input.send(@distance_measure, datum)
        pq.push([index, distance, datum], distance)
      end
      pq.dump.reverse
    rescue NoMethodError
      raise "Hey, that's not a measurement. Read the README for available measurements"
    end
  end  
end