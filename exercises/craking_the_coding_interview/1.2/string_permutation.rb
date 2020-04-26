class String
  def permutation?(string)
    return false if self.size != string.size
    self.chars.sort == string.chars.sort
  end
end
