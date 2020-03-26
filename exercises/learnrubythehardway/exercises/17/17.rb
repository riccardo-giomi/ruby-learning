#!/usr/bin/env ruby
# frozen_string_literal: true

from_file, to_file = ARGV

unless from_file && to_file
  puts 'Usage: ruby 17.rb ORIGIN DESTINATION'
  exit
end

puts "Copying from #{from_file} to #{to_file}."

# We could do whese two on one line, how?
# in_file = File.open(from_file)
# in_data = in_file.read
data = File.read(from_file)

puts "The input file is #{data.length} bytes long."
puts "Does the output file exist? #{File.exist?(to_file)}"
puts 'Ready, hit RETURN to continue, CTRL-C to abort.'
$stdin.gets

# out_file = open(to_file, 'w')
# out_file.write(data)

File.write(to_file, data)
puts 'Allright, all done.'

# out_file.close
# in_file.close
