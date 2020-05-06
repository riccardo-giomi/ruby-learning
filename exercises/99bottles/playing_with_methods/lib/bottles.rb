# frozen_string_literal: true

class Bottles
  attr_reader :beverage

  def initialize(beverage: 'beer')
    @beverage = beverage
  end

  def verse(bottles)
    __send__("verse_#{bottles}")
  rescue NoMethodError
    verse_n(bottles)
  end

  def verses(from, to)
    from.downto(to).map { |n| verse(n) }.join("\n")
  end

  def song
    verses(99, 0)
  end

  private

  def verse_0
    <<~VERSE
      #{bottles_on_the_wall(0).capitalize}, #{bottles(0)}.
      Go to the store and buy some more, #{bottles_on_the_wall(99)}.
    VERSE
  end

  def verse_n(n)
    <<~VERSE
      #{bottles_on_the_wall(n)}, #{bottles(n)}.
      #{take_and_pass(n)}, #{bottles_on_the_wall(n - 1)}.
    VERSE
  end

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
