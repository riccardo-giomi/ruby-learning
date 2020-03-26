#!/usr/bin/env ruby
# frozen_string_literal: true

from_file, to_file = ARGV

unless from_file && to_file
  puts 'Usage: ruby 17.rb ORIGIN DESTINATION'
  exit
end

File.write(to_file, File.read(from_file))
