class String
  def unique?
    self.each_char do |c|
      return false if self.count(c) > 1
    end
    true
  end
end
