#!/usr/bin/env ruby
# frozen_string_literal: true

formatter = '%<first>s %<second>s %<third>s %<fourth>s'

puts format(formatter, first: 1, second: 2, third: 3, fourth: 4)
puts format(formatter, first: 'one', second: 'two', third: 'three', fourth: 'four')
puts format(formatter, first: true, second: false, third: true, fourth: false)
puts format(formatter, first: formatter, second: formatter, third: formatter, fourth: formatter)

puts format(formatter, first: 'I had this thing.',
                       second: 'That you could type right up.',
                       third: "But it didn't sing.",
                       fourth: 'So I said goodnight.')
