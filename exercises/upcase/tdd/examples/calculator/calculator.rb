#!/usr/bin/env ruby

require 'rspec/autorun'

class Calculator
  def add(n, m)
    n + m
  end

  def factorial(n)
    # Would crash with big numbers
    # n > 0 ? n*factorial(n-1) : 1
    (1..n).reduce(1, :*)
  end
end

describe Calculator do
  describe '#add' do
    it 'it returns the sum of its two arguments' do
      calc = Calculator.new
      expect(calc.add(5, 10)).to eq 15
    end

    it 'returns the same of two different arguments' do
      calc = Calculator.new
      expect(calc.add(1, 2)).to eq 3
    end
  end

  describe '#factorial' do
    it 'returns one when given zero' do
      calc = Calculator.new
      expect(calc.factorial(0)).to eq 1
    end

    it 'returns 120 when given 5' do
      calc = Calculator.new
      expect(calc.factorial(5)).to eq 120
    end
  end
end
