# frozen_string_literal: true

RSpec.shared_examples '90 degrees right rotation' do

  def create(matrix)
    described_class.new(matrix)
  end

  it 'correctly rotates a 2 by 2 matrix' do
    matrix  = [[1, 2],
               [3, 4]]

    rotated = [[3, 1],
               [4, 2]]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a different 2 by 2 matrix' do
    matrix  = [['A', 'B'],
               ['C', 'D']]

    rotated = [['C', 'A'],
               ['D', 'B']]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a 3 by 3 matrix' do
    matrix  = [[1, 2, 3],
               [4, 5, 6],
               [7, 8, 9]]

    rotated = [[7, 4, 1],
               [8, 5, 2],
               [9, 6, 3]]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates another 3 by 3 matrix' do
    matrix  = [['A', 'B', 'C'],
               ['D', 'E', 'F'],
               ['G', 'H', 'I']]

    rotated = [['G', 'D', 'A'],
               ['H', 'E', 'B'],
               ['I', 'F', 'C']]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a 4 by 4 matrix' do
    matrix  = [[ 1,  2,  3,  4],
               [ 5,  6,  7,  8],
               [ 9, 10, 11, 12],
               [13, 14, 15, 16]]

    rotated = [[13,  9,  5,  1],
               [14, 10,  6,  2],
               [15, 11,  7,  3],
               [16, 12,  8,  4]]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a 5 by 5 matrix' do
    matrix  = [['A', 'B', 'C', 'D', 'E'],
               ['F', 'G', 'H', 'I', 'J'],
               ['K', 'L', 'M', 'N', 'O'],
               ['P', 'Q', 'R', 'S', 'T'],
               ['U', 'V', 'X', 'Y', 'Z']]

    rotated = [['U', 'P', 'K', 'F', 'A'],
               ['V', 'Q', 'L', 'G', 'B'],
               ['X', 'R', 'M', 'H', 'C'],
               ['Y', 'S', 'N', 'I', 'D'],
               ['Z', 'T', 'O', 'J', 'E']]

    expect(create(matrix).rotate_right).to eq rotated
  end


  it 'correctly rotates a 6 by 6 matrix' do
    matrix  = [[ 0,  1,  2,  3,  4,  5],
               [ 6,  7,  8,  9, 10, 11],
               [12, 13, 14, 15, 16, 17],
               [18, 19, 20, 21, 22, 23],
               [24, 25, 26, 27, 28, 29],
               [30, 31, 32, 33, 34, 35]]

    rotated = [[30, 24, 18, 12,  6, 0],
               [31, 25, 19, 13,  7, 1],
               [32, 26, 20, 14,  8, 2],
               [33, 27, 21, 15,  9, 3],
               [34, 28, 22, 16, 10, 4],
               [35, 29, 23, 17, 11, 5]]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a 7 by 7 matrix' do
    matrix  = [[ 0,  1,  2,  3,  4,  5,  6], 
               [ 7,  8,  9, 10, 11, 12, 13],
               [14, 15, 16, 17, 18, 19, 20],
               [21, 22, 23, 24, 25, 26, 27],
               [28, 29, 30, 31, 32, 33, 34],
               [35, 36, 37, 38, 39, 40, 41],
               [42, 43, 44, 45, 46, 47, 48]]


    rotated = [[42, 35, 28, 21, 14,  7, 0],
               [43, 36, 29, 22, 15,  8, 1],
               [44, 37, 30, 23, 16,  9, 2],
               [45, 38, 31, 24, 17, 10, 3],
               [46, 39, 32, 25, 18, 11, 4],
               [47, 40, 33, 26, 19, 12, 5],
               [48, 41, 34, 27, 20, 13, 6]]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a 8 by 8 matrix' do
    matrix  = [[ 0,  1,  2,  3,  4,  5,  6,  7],
               [ 8,  9, 10, 11, 12, 13, 14, 15],
               [16, 17, 18, 19, 20, 21, 22, 23],
               [24, 25, 26, 27, 28, 29, 30, 31],
               [32, 33, 34, 35, 36, 37, 38, 39],
               [40, 41, 42, 43, 44, 45, 46, 47],
               [48, 49, 50, 51, 52, 53, 54, 55],
               [56, 57, 58, 59, 60, 61, 62, 63]]

    rotated = [[56, 48, 40, 32, 24, 16,  8, 0],
               [57, 49, 41, 33, 25, 17,  9, 1],
               [58, 50, 42, 34, 26, 18, 10, 2],
               [59, 51, 43, 35, 27, 19, 11, 3],
               [60, 52, 44, 36, 28, 20, 12, 4],
               [61, 53, 45, 37, 29, 21, 13, 5],
               [62, 54, 46, 38, 30, 22, 14, 6],
               [63, 55, 47, 39, 31, 23, 15, 7]]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a 9 by 9 matrix' do
    matrix  = [[ 0,  1,  2,  3,  4,  5,  6,  7,  8],
               [ 9, 10, 11, 12, 13, 14, 15, 16, 17],
               [18, 19, 20, 21, 22, 23, 24, 25, 26],
               [27, 28, 29, 30, 31, 32, 33, 34, 35],
               [36, 37, 38, 39, 40, 41, 42, 43, 44],
               [45, 46, 47, 48, 49, 50, 51, 52, 53],
               [54, 55, 56, 57, 58, 59, 60, 61, 62],
               [63, 64, 65, 66, 67, 68, 69, 70, 71],
               [72, 73, 74, 75, 76, 77, 78, 79, 80]]

    rotated = [[72, 63, 54, 45, 36, 27, 18,  9, 0],
               [73, 64, 55, 46, 37, 28, 19, 10, 1],
               [74, 65, 56, 47, 38, 29, 20, 11, 2],
               [75, 66, 57, 48, 39, 30, 21, 12, 3],
               [76, 67, 58, 49, 40, 31, 22, 13, 4],
               [77, 68, 59, 50, 41, 32, 23, 14, 5],
               [78, 69, 60, 51, 42, 33, 24, 15, 6],
               [79, 70, 61, 52, 43, 34, 25, 16, 7],
               [80, 71, 62, 53, 44, 35, 26, 17, 8]]

    expect(create(matrix).rotate_right).to eq rotated
  end

  it 'correctly rotates a 10 by 10 matrix' do
    matrix  = [[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9],
               [10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
               [20, 21, 22, 23, 24, 25, 26, 27, 28, 29],
               [30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
               [40, 41, 42, 43, 44, 45, 46, 47, 48, 49],
               [50, 51, 52, 53, 54, 55, 56, 57, 58, 59],
               [60, 61, 62, 63, 64, 65, 66, 67, 68, 69],
               [70, 71, 72, 73, 74, 75, 76, 77, 78, 79],
               [80, 81, 82, 83, 84, 85, 86, 87, 88, 89],
               [90, 91, 92, 93, 94, 95, 96, 97, 98, 99]]

    rotated = [[90, 80, 70, 60, 50, 40, 30, 20, 10, 0],
               [91, 81, 71, 61, 51, 41, 31, 21, 11, 1],
               [92, 82, 72, 62, 52, 42, 32, 22, 12, 2],
               [93, 83, 73, 63, 53, 43, 33, 23, 13, 3],
               [94, 84, 74, 64, 54, 44, 34, 24, 14, 4],
               [95, 85, 75, 65, 55, 45, 35, 25, 15, 5],
               [96, 86, 76, 66, 56, 46, 36, 26, 16, 6],
               [97, 87, 77, 67, 57, 47, 37, 27, 17, 7],
               [98, 88, 78, 68, 58, 48, 38, 28, 18, 8],
               [99, 89, 79, 69, 59, 49, 39, 29, 19, 9]]

    expect(create(matrix).rotate_right).to eq rotated
  end
end