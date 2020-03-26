class Player
  attr_reader :name
  attr_accessor :score, :final_turn, :done
  alias_method :done?, :done
  alias_method :final_turn?, :final_turn

  def initialize(name)
    @name = name
    reset
  end

  def in_the_game?
    score >= 300
  end

  def reset
    @score = 0
    @done  = @final_turn = false
  end

  def set_final_turn
    @final_turn = true
    @done       = false
  end

  def set_done
    @final_turn = false
    @done       = true
  end

  def to_s
    name
  end

  def inspect
    "#{name}: #{score}"
  end
end
