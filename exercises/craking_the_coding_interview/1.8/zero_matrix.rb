class ZeroMatrix
    def call(matrix)
        # [[1,1]]
        return matrix if matrix.first.count(0).zero?
        [matrix.first.map { 0 }]
    end
end