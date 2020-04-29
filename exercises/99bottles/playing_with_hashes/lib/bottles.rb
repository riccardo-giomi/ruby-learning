# frozen_string_literal: true

class Bottles
  def initialize
    @verses = Hash.new do |hash, key|
      hash[key] = <<~VERSE
        #{key} bottles of beer on the wall, #{key} bottles of beer.
        Take one down and pass it around, #{key - 1} bottles of beer on the wall.
      VERSE
    end

    @verses[0] = <<~VERSE
      No more bottles of beer on the wall, no more bottles of beer.
      Go to the store and buy some more, 99 bottles of beer on the wall.
    VERSE

    @verses[1] = <<~VERSE
      1 bottle of beer on the wall, 1 bottle of beer.
      Take it down and pass it around, no more bottles of beer on the wall.
    VERSE

    @verses[2] = <<~VERSE
      2 bottles of beer on the wall, 2 bottles of beer.
      Take one down and pass it around, 1 bottle of beer on the wall.
    VERSE
  end

  def verse(bottles)
    @verses[bottles]
  end

  def verses(from, to)
    (to..from).reduce([]) { |s, i| s.unshift(verse(i)) }.join("\n")
  end

  def song
    verses(99, 0)
  end
end
