# frozen_string_literal: true

require_relative '../palindrome_permutation'

RSpec.describe PalindromePermutation do
  context '#eligible?' do
    def eligible?(string)
      described_class.new(string).eligible?
    end

    it 'returns true if there is a palindrome permutation' do
      # Amore, Roma.
      expect(eligible?('more, ARoma')).to be true
    end

    it 'returns true if the string is already a palindrome' do
      expect(eligible?('A nut for a jar of tuna')).to be true
    end

    it 'ignores spaces' do
      expect(eligible?('bab a ')).to be true
    end

    it 'ignores case' do
      expect(eligible?('Tact Coa')).to be true
    end

    it 'ignores puntuation and other symbols' do
      expect(eligible?('Ta.ct@Coa')).to be true
    end

    context 'returns true' do
      example 'for `aa`' do
        expect(eligible?('aa')).to be true
      end

      example 'for `aba`' do
        expect(eligible?('aba')).to be true
      end

      example 'for `abb`' do
        expect(eligible?('abb')).to be true
      end

      example 'for `abba`' do
        expect(eligible?('abba')).to be true
      end

      example 'for `abcba`' do
        expect(eligible?('abcba')).to be true
      end
    end

    context 'returns false' do
      example 'for an empty string' do
        expect(eligible?('')).to be false
      end

      example 'for a single character' do
        expect(eligible?('a')).to be false
      end

      example 'for ` a `' do
        expect(eligible?(' a ')).to be false
      end

      example 'for `ab`' do
        expect(eligible?('ab')).to be false
      end

      example 'for `abc`' do
        expect(eligible?('abc')).to be false
      end

      example 'for `abbc`' do
        expect(eligible?('abbc')).to be false
      end
    end
  end
end
