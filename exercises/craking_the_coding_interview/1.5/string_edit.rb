class StringEdit
  def initialize(value)
    @value = value
  end

  def one_edit_away?(string)
    return false unless string.size.between?(@value.size - 1, @value.size + 1)
    return true if @value == string

    return differ_by_one_char?(@value, string)
  end

  private

  def differ_by_one_char?(string1, string2)
    same_size = string1.size == string2.size
    bigger, smaller = sort_by_size(string1, string2, same_size)

    bigger.each_char.with_index do |char, index|
      return same_without_difference?(bigger, smaller, char, index, same_size) if char != smaller[index]
    end
    true
  end

  def sort_by_size(string1, string2, same_size)
      return [string1, string2] if same_size

      [string1, string2].sort {
        |s1, s2| s2.size <=> s1.size
      }
  end

  def same_without_difference?(bigger, smaller, char, index, same_size)
      return bigger == smaller[0..index - 1] + char + smaller[index..smaller.size] unless same_size
      smaller[index] = char
      bigger == smaller
  end
end
