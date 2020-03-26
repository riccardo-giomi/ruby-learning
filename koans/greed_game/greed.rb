#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/game'

def get_players
  puts 'Welcome to the Greed Game, please write each player name and press <ENTER>.'
  puts 'Press <Enter> (leave an empty name) when done.'
  puts
  puts 'Players (need at least 2):'

  players = []
  loop do
    player = gets.strip
    if player.empty?
      break if players.size > 1

      puts 'Please insert at least 2 players'
    elsif players.include? player
      puts 'This name is already used, please choose another'
    else
      players << player
    end
  end
  players
end

def player_status_message(player)
  puts "#{player}, your score is #{player.score}."

  unless player.in_the_game?
    puts 'You are not "in the game" yet, score at least 300 points in a turn.'
  end
  puts 'Press <ENTER> to roll the dice'
end

def turn_status_message(turn)
  puts 'This is your final turn!' if turn.final?

  puts %{You rolled: #{turn.dice} (#{turn.scoring_dice} = #{turn.dice_score}, #{turn.non_scoring_dice} scored nothing)}
  puts

  if turn.dice_score.zero?
    puts 'You scored no points and this turn ends with no score.'
    puts 'Press <Enter> to end your turn.'
  else
    dice_string   = dice_or_die(turn.available_dice)
    n_dice_string = number_of_dice(turn.available_dice)
    print %(You have scored #{turn.score} points in this turn, and can still roll #{n_dice_string})
    if turn.in_the_game?
      puts '.'
    else
      puts %(,\nbut you still have to score #{300 - turn.score} points to be in the game or these will be lost.)
    end
    puts %(Roll again the remaining #{dice_string}? [y/N])
  end
end

def end_game_message(game)
  print 'The game ended, '
  if game.winners.size == 1
    print "the winner is #{game.winners.first} "
  else
    print "#{game.winners.join(', ')} tie at first place "
  end
  print "with #{game.scores[game.winners.first]} points"

  puts
  scores_message 'Final scores:', game
  puts
end

def scores_message(title, game)
  puts
  puts title
  game.scores.each do |player, score|
    puts "#{player}: #{score}"
  end
  puts
end

def dice_or_die(n)
  n == 1 ? 'die' : 'dice'
end

def number_of_dice(n)
  return 'no dice' if n.zero?

  "#{n} #{dice_or_die(n)}"
end

players = get_players
Game.new(*players).start do |game|
  until game.ended?

    game.turn do |turn|
      system('clear') || system('cls')

      scores_message 'The points so far:', game
      player_status_message turn.player
      gets
      turn.roll

      loop do
        turn_status_message turn
        input = gets
        if turn.dice_available? && input.strip.downcase == 'y'
          turn.roll
        else
          break
        end
      end
    end

  end

  end_game_message game
end
