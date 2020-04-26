class String
  def urlify
    self.strip.gsub(' ', '%20')
  end
end
