# frozen_string_literal: true

require_relative '../string_rotated'

RSpec.describe String do
  context '#rotated?' do
    it 'returns true if the argument is the same as the string' do
      expect('waterbottle'.rotated?('waterbottle')).to be true
    end

    context 'returns true if the argument is a "rotation" of the input string' do
      example { expect('waterbottle'.rotated?('erbottlewat')).to be true }
      example { expect('waterbottle'.rotated?('bottlewater')).to be true }
    end

    it 'returns true if both strings are empty' do
      expect(''.rotated?('')).to be true
    end

    it 'returns false if the argument of different size' do
      expect('something'.rotated?('somethingelse')).to be false
    end

    context 'returns false if the strings are not one the rotation of the other' do
      example { expect('something'.rotated?('thimesong')).to be false }
      example { expect('something'.rotated?('aingsomet')).to be false }
    end
  end
end
