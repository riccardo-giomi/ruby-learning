#!/usr/bin/env ruby

require 'rspec/autorun'

DimensionalMismatchError = Class.new(StandardError)
Quantity = Struct.new(:amount, :units)

class UnitConverter
  def initialize(quantity, to)
    @quantity = quantity
    @to       = to
  end

  def convert
    Quantity.new(
      @quantity.amount * conversion_factor(from: @quantity.units, to: @to),
      @to
    )
  end

  private

  CONVERSION_FACTORS = {
    liters: {
      cups: 4.226775,
      liters: 1,
      pints: 2.11338
    },
    grams: {
      grams: 1,
      kilograms: 1000
    }
  }.freeze

  def conversion_factor(from:, to:)
    dimension = common_dimension(from, to) ||
                raise(DimensionalMismatchError, "Can't convert from #{from} to #{to}.")
    CONVERSION_FACTORS.dig(dimension, to) / CONVERSION_FACTORS.dig(dimension, from)
  end

  def common_dimension(from, to)
    CONVERSION_FACTORS.keys.find do |canonical_unit|
      CONVERSION_FACTORS[canonical_unit].keys.include?(from) &&
        CONVERSION_FACTORS[canonical_unit].keys.include?(to)
    end
  end
end

describe UnitConverter do
  describe '#convert' do
    it 'converts between quantities of the same unit' do
      cups = Quantity.new(2, :cups)
      converter = UnitConverter.new(cups, :cups)

      cups_again = converter.convert

      expect(cups_again.units).to eq :cups
      expect(cups_again.amount).to be_within(0.001).of(2)
    end

    it 'converts from cups to liters' do
      cups = Quantity.new(2, :cups)
      converter = UnitConverter.new(cups, :liters)

      liters = converter.convert

      expect(liters.units).to eq :liters
      expect(liters.amount).to be_within(0.001).of(0.473)
    end

    it 'raises an error if the units of measure are not compatible' do
      cups = Quantity.new(2, :cups)
      converter = UnitConverter.new(cups, :grams)

      expect { converter.convert }.to raise_error(DimensionalMismatchError)
    end
  end
end
