# frozen_string_literal: true

class String
  def rotated_from?(string)
    return false unless length == string.length

    true if string == self
    (string * 2).include?(self)
  end
end
