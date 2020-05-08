class ZeroMatrix
  def call(matrix)
    columns_with_zero = []

    matrix.map! do |row|
      row_has_zeros = false
      row.each_with_index do |col, j|
        if col.zero?
          row_has_zeros = true
          columns_with_zero << j
        end
      end

      row_has_zeros ? row.map { 0 } : row
    end

    columns_with_zero.each do |j|
      matrix.each_with_index do |row, i|
        matrix[i][j] = 0
      end
    end

    matrix
  end
end
