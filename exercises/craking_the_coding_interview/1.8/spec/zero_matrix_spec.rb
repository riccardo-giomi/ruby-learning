require '../zero_matrix'

RSpec.describe ZeroMatrix do
  let(:zero_matrix) { ZeroMatrix.new }

  context 'with a single row' do
    context 'without zeros' do
      example do
        matrix = [[1,1]]

        expect(zero_matrix.call(matrix)).to eq matrix
      end

      example do
        matrix = [[1,2]]

        expect(zero_matrix.call(matrix)).to eq matrix
      end
    end

    context 'with zeroes' do
      example do
        matrix   = [[0, 1]]
        expected = [[0, 0]]

        expect(zero_matrix.call(matrix)).to eq expected
      end

      example do
        matrix   = [[1, 0]]
        expected = [[0, 0]]

        expect(zero_matrix.call(matrix)).to eq expected
      end

      example do
        matrix   = [[0, 0, 2]]
        expected = [[0, 0, 0]]

        expect(zero_matrix.call(matrix)).to eq expected
      end

      example do
        matrix   = [[0, 3, 0]]
        expected = [[0, 0, 0]]

        expect(zero_matrix.call(matrix)).to eq expected
      end
    end
  end

  context 'with two rows' do
    context 'without zeros' do
      example do

        matrix = [[1, 2],
                  [3, 4]]

        expect(zero_matrix.call(matrix)).to eq matrix
      end
    end

    context 'with zeros' do
      example do
        matrix   = [[1, 2],
                    [0, 3]]

        expected = [[0, 2],
                    [0, 0]]

        expect(zero_matrix.call(matrix)).to eq expected
      end

      example do
        matrix   = [[1, 2, 3],
                    [4, 0, 6]]

        expected = [[1, 0, 3],
                    [0, 0, 0]]

        expect(zero_matrix.call(matrix)).to eq expected
      end

      example do
        matrix   = [[1, 2, 0],
                    [4, 0, 6]]

        expected = [[0, 0, 0],
                    [0, 0, 0]]

        expect(zero_matrix.call(matrix)).to eq expected
      end
    end
  end

  context 'with three rows' do
    context 'without zeros' do
      example do

        matrix = [[1, 2],
                  [3, 4],
                  [5, 6]]

        expect(zero_matrix.call(matrix)).to eq matrix
      end
    end

    context 'with zeros' do
      example do
        matrix   = [[1, 2],
                    [0, 4],
                    [5, 6]]

        expected = [[0, 2],
                    [0, 0],
                    [0, 6]]

        expect(zero_matrix.call(matrix)).to eq expected
      end

      example do
        matrix   = [[1, 2, 3],
                    [4, 0, 6],
                    [7, 8, 9]]

        expected = [[1, 0, 3],
                    [0, 0, 0],
                    [7, 0, 9]]

        expect(zero_matrix.call(matrix)).to eq expected
      end
    end
  end
end
