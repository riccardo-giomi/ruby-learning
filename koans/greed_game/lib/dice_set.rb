class DiceSet
  attr_reader :values

  def initialize
    @values = []
  end

  def roll(n)
    @values = []
    n.times {@values << rand(1..6).to_i}
    values
  end
end
