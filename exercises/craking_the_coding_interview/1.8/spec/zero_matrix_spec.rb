require '../zero_matrix'

RSpec.describe ZeroMatrix do
    context 'with a single row matrix' do
        context 'without zeros' do
            it 'does not change [[1,1]]' do
                zero_matrix = ZeroMatrix.new 
                matrix = [[1,1]]
                expect(zero_matrix.call(matrix)).to eq(matrix)
            end

            it 'does not change [[1,2]]' do
                zero_matrix = ZeroMatrix.new 
                matrix = [[1,2]]
                expect(zero_matrix.call(matrix)).to eq(matrix)
            end
        end
        context 'with one zero' do
            it 'changes [[0,1]]' do
                zero_matrix = ZeroMatrix.new 
                matrix = [[0,1]]
                expect(zero_matrix.call(matrix)).to eq([[0,0]])
            end
            it 'changes [[1,0]]' do
                zero_matrix = ZeroMatrix.new 
                matrix = [[1,0]]
                expect(zero_matrix.call(matrix)).to eq([[0,0]])
            end
        end
        context 'with two zeros' do
            it 'changes [[0,0,2]]' do
                zero_matrix = ZeroMatrix.new 
                matrix = [[0,0,2]]
                expect(zero_matrix.call(matrix)).to eq([[0,0,0]])
            end
        end
    end
end