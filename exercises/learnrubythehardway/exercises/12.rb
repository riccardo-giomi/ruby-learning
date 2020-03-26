#!/usr/bin/env ruby
# frozen_string_literal: true

print 'Give me a number: '
number = gets.chomp.to_i

bigger = number * 100
puts "A bigger number is #{bigger}"

print 'Give me another number: '
another = gets.chomp.to_i

# smaller = another.to_f / 100
smaller = another / 100

puts "A smaller number is #{smaller}"

puts 'Drill extra:'
print 'Gimme some money: '
money = gets.chomp.to_f

change = money / 10
puts "Here's your change: #{change.round(2)}"
