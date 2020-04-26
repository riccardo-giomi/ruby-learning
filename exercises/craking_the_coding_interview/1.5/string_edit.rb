class StringEdit
  def initialize(value)
    @value = value
  end

  def one_edit_away?(string)
    return false unless string.size.between?(@value.size - 1, @value.size + 1)
    return true if @value == string
    differ_by_one_char?(@value, string)
  end

  private

  def differ_by_one_char?(string1, string2)

    if string1.size >= string2.size
      bigger, smaller = string1, string2
    elsif string2.size > string1.size
      bigger, smaller = string2, string1
    end

    n_differences = 0
    bigger.chars.uniq.each do |c|
      n_differences += (bigger.count(c) - smaller.count(c)).abs
      return false if n_differences > 1
    end
    true
  end
end
