# frozen_string_literal: true

class StringCompression
  def call(string)
    return string if string.size < 3

    result = +''

    i, j, count = 0, 1, 1

    while i < string.size
      current_char = string[i]
      next_char    = string[j]

      while next_char == current_char
        count += 1
        j     += 1
        next_char = string[j]
      end

      result << "#{current_char}#{count}"
      return string if result.size >= string.size

      i     = j
      count = 0
    end

    result.size < string.size ? result : string
  end
end
