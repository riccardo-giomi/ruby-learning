require_relative 'player'
require_relative 'turn'
require_relative 'score'

class Game

  attr_reader :players, :player
  def initialize(*player_names)
    players = player_names.reject {|name| name.strip.empty?}

    raise PlayerExistsError if players.size != players.uniq.size

    @players = players.map {|name| Player.new name}
  end

  def next_player
    return players.first if player.nil?
    current_index = players.find_index player
    @player = players.fetch(current_index + 1, players.first)
  end

  def scores
    players.reduce({}) {|scores, player| scores[player.to_s] = player.score; scores}
  end

  def start
    raise NotEnoughPlayersError if players.size < 2
    reset_game

    yield self if block_given?
    self
  end

  def turn(&block)
    raise GameEndedError if ended?
    @player = next_player
    turn = Turn.new player
    block.call turn
    update_players turn
    self
  end

  def final_turns?
    @players.any? {|player| player.final_turn?}
  end

  def ended?
    @players.count {|player| player.done?} == @players.size
  end

  def winners
    max_score = @players.max_by(&:score).score
    @players.filter {|player| player.score == max_score}.map &:to_s
  end

  def inspect
    "#{scores}"
  end

  private def update_players(turn)
    @player.score += turn.score if turn.in_the_game?

    if @player.score >= 3000 and !final_turns?
      players.each {|player| player.set_final_turn}
    end

    @player.set_done if @player.final_turn?
  end

  private def reset_game
    players.each &:reset
    @player = nil
  end

  class PlayerExistsError      < StandardError; end
  class NotEnoughPlayersError  < StandardError; end
  class GameEndedError         < StandardError; end
end
