class Array
  def euclidean_distance_from(other)
    sum = 0.0
    self.each_with_index do |datum, index|
      sum += (datum - other[index]) ** 2
    end
    Math.sqrt(sum)
  end
end