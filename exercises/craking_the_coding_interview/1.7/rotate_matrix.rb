class RotateMatrix

  attr_reader :matrix
  def initialize(matrix)
    @matrix = matrix
  end

  alias_method :to_a,   :matrix
  alias_method :to_ary, :matrix

  def call(dir: :right)
    rotate(dir) if n > 1
    self
  end

  private

  def n
    @matrix.size
  end

  def rotate(dir)
    max_layers = n / 2
    (0...max_layers).each { |layer| rotate_layer(layer, dir) }
  end

  def rotate_layer(layer, dir)
    max_offset = n - 1 - 2 * layer
    (0...max_offset).each do |offset| 
      dir == :left ?  rotate_four_left(layer, offset) : rotate_four_right(layer, offset)
    end
  end

  def rotate_four_left(layer, offset)
    first, last = layer, n - 1 - layer
    top_left_value                 = @matrix[first][first + offset] # save top-left
    @matrix[first][first + offset] = @matrix[first + offset][last]  # top-right into top-left
    @matrix[first + offset][last]  = @matrix[last][last - offset]   # bottom-right into top-left
    @matrix[last][last - offset]   = @matrix[last - offset][first]  # bottom-left into bottom-right
    @matrix[last - offset][first]  = top_left_value                 # saved top-left into bottom-left
  end

  def rotate_four_right(layer, offset)
    first, last = layer, n - 1 - layer
    top_left_value                 = @matrix[first][first + offset] # save top-left
    @matrix[first][first + offset] = @matrix[last - offset][first]  # bottom-left into top-left
    @matrix[last - offset][first]  = @matrix[last][last - offset]   # bottom-left into bottom-left
    @matrix[last][last - offset]   = @matrix[first + offset][last]  # top-left into bottom-left
    @matrix[first + offset][last]  = top_left_value                 # saved top-left into top-left
  end
end
