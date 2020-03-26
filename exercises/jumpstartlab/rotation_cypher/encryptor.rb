#!/usr/bin/env/ruby
# frozen_string_literal: true

# Implementation of Julius Ceasar ROT13 encryption algorithm
# Conversion table:
# A => N
# B => O
# C => P
# D => Q
# E => R
# F => S
# G => T
# H => U
# I => V
# J => W
# K => X
# L => Y
# M => Z
# ... from here it's the reverse
class Encryptor
  CYPHER = 'nopqrstuvwxyzabcdefghijklm'
  def encrypt(string)
    result = +''
    string.each_char { |char| result << encrypt_char(char) }
    result
  end

  def decrypt(string)
    encrypt(string)
  end

  private

  def encrypt_char(char)
    return char unless ('a'..'z').include?(char.downcase)

    new_char = CYPHER[char.downcase.ord - 'a'.downcase.ord]
    char.upcase == char ? new_char.upcase : new_char
  end
end
