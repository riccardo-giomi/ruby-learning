class String
  def rotated?(from)
    return false unless self.length == from.length
    true if from == self
    (from * 2).include?(self)
  end
end
