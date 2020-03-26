#!/usr/bin/env ruby
# frozen_string_literal: true

filename = ARGV.first

unless filename
  puts 'Usage: ruby 16.rb FILE'
  exit
end

puts "We are going to erase #{filename}"
puts "if you don't want to do that, hit CTRL-C (^C)."
puts 'if you do want that, hit RETURN.'

$stdin.gets.chomp

puts "Opening the file and clearing it's content..."
target = File.open filename, 'w'

puts "Now I'm going to ask you for three lines."

print 'Line 1: '
line1 = $stdin.gets.chomp

print 'Line 2: '
line2 = $stdin.gets.chomp

print 'Line 3: '
line3 = $stdin.gets.chomp

puts 'I am going to write these to the file.'
target.write("#{line1}\n#{line2}\n#{line3}")

puts 'And finally, we close it.'
target.close

puts 'This is what was written:'
txt = File.open filename
puts txt.read
txt.close
