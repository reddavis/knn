require_relative 'fixed_queue'

module KNN_MODULE
  # Mixin for calculating distance in VPNode and VPTree
  # compatable with Distance-measure gem
  module CalcDistance
    def calc_dist(obj1, obj2)
      return @is_block ? obj1.distance(obj2, &@distance_measure) : obj1.distance(obj2, @distance_measure)
    rescue
      # old fasion distance gem, for arrays only
      return @is_block ? @distance_measure.call(obj1, obj2) : obj1.send(@distance_measure, obj2)
    end
  end

  class KNN
    include CalcDistance
    def initialize(data, options={}, &block)
      @data = data
      @is_block = block != nil
      @distance_measure = block || options[:distance_measure]  || :euclidean_distance
    end

    def nearest_neighbours(input, k=4)
      find_closest_data(input, k)
    end

    def find_k_nearest(input, k)
      find_closest_data(input, k).map{|x| x[1..2]}
    end

    private

    def find_closest_data(input, k)
      pq = FixedLengthQueue.new(k)
      begin
        calculated_distances = []
        @data.each_with_index do |datum, index| #Ye olde english
          distance = calc_dist(input, datum)
          pq.push([index, distance, datum], distance)
        end
        pq.dump.reverse
      rescue NoMethodError => e
        raise "Hey, that's not a measurement: #{@distance_measure}, and block is #{@is_block}.\n Read the README for available measurements"
      end
    end  
  end
end
