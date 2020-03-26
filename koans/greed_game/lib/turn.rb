require_relative 'player'
require_relative 'dice_set'

class Turn
  attr_reader :player, :available_dice, :score
  attr_reader :dice, :dice_score, :scoring_dice, :non_scoring_dice
  def initialize(player)
    @player         = player
    @available_dice = 5
    @dice_set       = DiceSet.new
    @score          = 0
  end

  def dice_available?
    available_dice > 0
  end

  def in_the_game?
    player.score + score >= 300
  end

  def final?
    player.final_turn?
  end

  def roll(dice=nil)
    return [] unless dice_available?

    @dice = dice.nil? ? @dice_set.roll(available_dice) : dice
    @dice.sort!
    @dice_score = Score.calculate(@dice) do |scoring, non_scoring|
      @scoring_dice     = scoring.sort
      @non_scoring_dice = non_scoring
      @available_dice   = non_scoring.size
    end

    if @non_scoring_dice.size.zero?
      @available_dice = 5 
    elsif @dice_score.zero?
      @available_dice = 0 
    end

    @score = @dice_score.zero? ? 0 : @dice_score + score

    @dice
  end
end
