#!/usr/bin/env ruby
# frozen_string_literal: true

# Here's some strange stuff, remember: type it exactly.

days = 'Mon Tue Wed Thu Fri Sun'
months = "Jan\nFeb\nMar\nApr\nMay\nJun\nJul\nAug"

puts "Here are the days: #{days}."
puts "Here are the months: #{months}."

# rubocop: disable Style/PercentLiteralDelimiters, Style/RedundantPercentQ
puts %q{
There's something going on here.
With this weird quote
we'll be able to type as much as we like.
Even 4 lines if we want, or 5, or 6.
}
# rubocop: enable Style/PercentLiteralDelimiters, Style/RedundantPercentQ
