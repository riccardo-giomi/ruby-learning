# frozen_string_literal: true

require_relative 'bottles/verse'
class Bottles
  def verse(bottles)
    Verse.create(bottles).to_s
  end

  def verses(from, to)
    from.downto(to).map { |n| verse(n) }.join("\n")
  end

  def song
    verses(99, 0)
  end
end
