class PalindromePermutation

  def initialize(string)
    @string = string
  end

  def eligible?
    characters = @string.downcase.gsub(/[^\w\d]/, '').chars
    return false if characters.size <= 1

    allowed_odd_count = characters.size.odd? ? 1 : 0
    characters.uniq.each do |c|
      allowed_odd_count -= 1 if characters.count(c).odd?
      return false if allowed_odd_count < 0
    end

    true
  end
end
