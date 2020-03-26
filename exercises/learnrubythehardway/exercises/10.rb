#!/usr/bin/env ruby
# frozen_string_literal: true

tabby_cat = "\tI'm tabbed in."
persian_cat = "I'm split\non a line."
backslash_cat = "I'm \\ a \\ cat."

# rubocop: disable Lint/ImplicitStringConcatenation
fat_cat = ''"
I'll do a list:
\t* Cat food
\t* Fishies
\t* Catnip\n\t* Grass
"''
# rubocop: enable Lint/ImplicitStringConcatenation

puts tabby_cat
puts persian_cat
puts backslash_cat
puts fat_cat
