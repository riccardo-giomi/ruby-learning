# frozen_string_literal: true

require_relative '../string_rotated'

RSpec.describe String do
  context '#rotated_from?' do
    it 'returns true if the argument is the same as the string' do
      expect('waterbottle'.rotated_from?('waterbottle')).to be true
    end

    context 'returns true if the argument is a "rotation" of the input string' do
      example { expect('waterbottle'.rotated_from?('erbottlewat')).to be true }
      example { expect('waterbottle'.rotated_from?('bottlewater')).to be true }
    end

    it 'returns true if both strings are empty' do
      expect(''.rotated_from?('')).to be true
    end

    it 'returns false it the string and the argument differ in size' do
      expect('something'.rotated_from?('somethingelse')).to be false
    end

    context 'returns false if the strings are not one the rotation of the other' do
      example { expect('something'.rotated_from?('thimesong')).to be false }
      example { expect('something'.rotated_from?('aingsomet')).to be false }
    end
  end
end
