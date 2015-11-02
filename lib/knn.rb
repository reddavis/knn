require 'distance_measures'
require_relative 'fixed_queue'

class KNN
  def initialize(data, options={}, &block)
    @data = data
    @is_block = block != nil
    @distance_measure = block || options[:distance_measure]  || :euclidean_distance
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
        distance = @is_block ? @distance_measure.call(input, datum) : input.send(@distance_measure, datum)
        pq.push([index, distance, datum], distance)
      end
      pq.dump.reverse
    rescue NoMethodError => e
      raise "Hey, that's not a measurement: #{@distance_measure}, and block is #{@is_block}.\n Read the README for available measurements"
    end
  end  
end