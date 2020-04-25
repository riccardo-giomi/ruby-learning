class MyMatrix

  attr_reader :matrix
  def initialize(matrix)
    @matrix = matrix
  end

  alias_method :to_a,   :matrix
  alias_method :to_ary, :matrix

  def rotate_right
    rotate do |row, col| rotate_four_right(row, col) end
  end

  def rotate_left
    rotate do |row, col| rotate_four_left(row, col) end
  end

  private

  def rotate(&block)
    max_col = max_row = n / 2
    max_col += 1 if n.odd?

    for row in 0...max_row do
      for col in 0...max_col do
        middle = n.odd? && col == row && row == max_row
        block.call(row, col) unless middle
      end
    end
    @matrix
  end

  def rotate_four_right(row, col)
    value = at(row, col)                  # starting point:
    moves_to = [col, n - 1 - row]         # moves to top-right equivalent;
    value = put_in(*moves_to, value)      # top-right equivalent element:
    moves_to = [n - 1 - row, n - 1 - col] # moves to bottom-right equivalent;
    value = put_in(*moves_to, value)      # bottom-right equivalent:
    moves_to = [n - 1 - col, row]         # moves to bottom-left equivalent;
    value = put_in(*moves_to, value)      # bottom-left equivalent:
    moves_to = [row, col]                 # moves to the starting point;
    put_in(*moves_to, value)
  end

  def rotate_four_left(row, col)
    value = at(row, col)                  # starting point:
    moves_to = [n - 1 - col, row]         # moves to bottom-left equivalent;
    value = put_in(*moves_to, value)      # bottom-left equivalent:
    moves_to = [n - 1 - row, n - 1 - col] # moves to bottom-right equivalent;
    value = put_in(*moves_to, value)      # bottom-right equivalent:
    moves_to = [col, n - 1 - row]         # moves to top-right equivalent;
    value = put_in(*moves_to, value)      # top-right equivalent element:
    moves_to = [row, col]                 # moves to the starting point;
    put_in(*moves_to, value)
  end

  def put_in(row, col, value)
    old_value = @matrix.dig(row, col)
    @matrix[row][col] = value
    old_value
  end

  def n
    @matrix.size
  end

  def at(x, y)
    @matrix.dig(x, y)
  end
end
