require_relative '../string_permutation'
RSpec.describe String do
  context '#permutation?' do
    it 'returns true when checking two empty strings' do
      expect(''.permutation?('')).to be true
    end

    context 'when the two strings contain the same characters' do
      it "returns true for 'abcdef' and 'fedcba'" do
        expect('abcdef'.permutation?('fedcba')).to be true
      end

      it "returns true for 'aab' and 'aba'" do
        expect('aab'.permutation?('aba')).to be true
      end
    end

    context 'when the two strings do not contain the same characters' do
      it "returns false for 'abcdef' and '123456'" do
        expect('abcdef'.permutation?('123456')).to be false
      end

      it "returns false for 'a' and 'aa'" do
        expect('a'.permutation?('aa')).to be false
      end
    end
  end
end
