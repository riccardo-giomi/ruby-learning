# frozen_string_literal: true

class Bottles
  attr_reader :beverage

  def initialize(beverage: 'beer')
    @beverage = beverage

    @verses = Hash.new do |hash, key|
      hash[key] = <<~VERSE
        #{bottles_on_the_wall(key)}, #{bottles(key)}.
        #{take_and_pass(key)}, #{bottles_on_the_wall(key - 1)}.
      VERSE
    end

    @verses[0] = <<~VERSE
      #{bottles_on_the_wall(0).capitalize}, #{bottles(0)}.
      Go to the store and buy some more, #{bottles_on_the_wall(99)}.
    VERSE
  end

  def verse(bottles)
    @verses[bottles]
  end

  def verses(from, to)
    from.downto(to).map { |n| verse(n) }.join("\n")
  end

  def song
    verses(99, 0)
  end

  private

  def bottles_on_the_wall(n)
    "#{bottles(n)} on the wall"
  end

  def take_and_pass(n)
    "Take #{n == 1 ? 'it' : 'one'} down and pass it around"
  end

  def bottles(n)
    bottles = case n
              when 0 then 'no more bottles'
              when 1 then '1 bottle'
              else        "#{n} bottles"
              end
    "#{bottles} of #{@beverage}"
  end
end
