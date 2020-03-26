#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/unit_converter.rb'

name = 'Zed A. Shaw'
age = 35 # not a lie in 2009
inches = Quantity.new(74, :inches) # inches
centimeters = UnitConverter.new(inches, :centimeters).convert
pounds = Quantity.new(180, :pounds) # lbs
kilograms = UnitConverter.new(pounds, :kilograms).convert
eyes = 'blue'
teeth = 'white'
hair = 'brown'

puts "Let's talk about #{name}."
puts "He's #{inches.amount} inches tall (or about #{centimeters.amount.round} cm)."
puts "He's #{pounds.amount} pounds heavy (that's about #{kilograms.amount.round} kg)."
puts "Actually that's not too heavy."
puts "He's got #{eyes} eyes and #{hair} hair."
puts "His teeth are usually #{teeth} depending on the coffee."

# this line is tricky, try to get it exactly right
puts "If I add #{age}, #{inches.amount}, and #{pounds.amount} I get #{age + inches.amount + pounds.amount}"
