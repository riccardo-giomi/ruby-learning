require_relative '../string_edit'

RSpec.describe StringEdit do
  context '#one_edit_away?' do
    let(:value) { 'pale' }
    subject {described_class.new(value)}

    context 'returns true' do
      example 'when the argument is the same' do
        expect(subject.one_edit_away?('pale')).to be true
      end

      example 'when the argument has one less letter' do
        expect(subject.one_edit_away?('ple')).to be true
      end

      example 'when the argument has one more letter' do
        expect(subject.one_edit_away?('pales')).to be true
      end

      example 'when the argument has one different letter' do
        expect(subject.one_edit_away?('bale')).to be true
      end
    end

    context 'returns false' do
      example 'when the argument is smaller by more than one letter' do
        expect(subject.one_edit_away?('pe')).to be false
      end

      example 'when the argument is bigger by more than one letter' do
        expect(subject.one_edit_away?('palles')).to be false
      end

      example 'when the argument differs by more than one character' do
        expect(subject.one_edit_away?('bake')).to be false
      end

      example 'when the argument is a permutation of a valid string' do
        expect(subject.one_edit_away?('elp')).to be false
      end
    end
  end
end
