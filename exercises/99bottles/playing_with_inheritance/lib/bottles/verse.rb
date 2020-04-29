# frozen_string_literal: true

class Bottles
  class Verse
    def self.create(bottles)
      eval("Verse#{bottles}").new(bottles)
    rescue NameError
      new(bottles)
    end

    def initialize(bottles)
      @bottles = bottles
    end

    def line1
      "#{@bottles} bottles of beer on the wall, #{@bottles} bottles of beer."
    end

    def line2
      "Take one down and pass it around, #{@bottles - 1} bottles of beer on the wall."
    end

    def to_str
      "#{line1}\n#{line2}\n"
    end
    alias to_s to_str

    class Verse0 < Verse
      def line1
        'No more bottles of beer on the wall, no more bottles of beer.'
      end

      def line2
        'Go to the store and buy some more, 99 bottles of beer on the wall.'
      end
    end

    class Verse1 < Verse
      def line1
        '1 bottle of beer on the wall, 1 bottle of beer.'
      end

      def line2
        'Take it down and pass it around, no more bottles of beer on the wall.'
      end
    end

    class Verse2 < Verse
      def line2
        'Take one down and pass it around, 1 bottle of beer on the wall.'
      end
    end
  end
end
