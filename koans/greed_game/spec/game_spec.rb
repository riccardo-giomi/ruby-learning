require 'game'

RSpec.configure do |c|
  c.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
ends

RSpec.describe Game do
  it "has players" do
    game = Game.new "Jim", "Bob"
    expect(game.players.first).to be_a Player
    expect(game.players.size).to eq 2
    expect(game.players.first.to_s).to eq "Jim"
  end

  it "cannot have two players with the same name" do
    expect {Game.new "Jim", "Jim"}.to raise_error Game::PlayerExistsError
  end

  it "does not consider empty player names" do
    game = Game.new "Jim" " \t"
    expect(game.players.size).to eq 1
  end

  it "can start or happen inside a block" do
    game = Game.new "Jim", "Bob", "Ann"
    expect(game).to respond_to :start
    expect {|b| game.start(&b)}.to yield_with_args Game
  end

  it "needs at least 2 playes to start" do
    expect {Game.new.start}.to raise_error Game::NotEnoughPlayersError
  end

  it "knows who the first player will be" do
    game = Game.new("Jim", "Bob").start
    expect(game.next_player.to_s).to eq "Jim"
  end

  context "when ongoing" do
    subject(:game) {Game.new("Bob", "Jim")}

    it "can cycle through the players' turns" do
      expect(game).to respond_to :turn
      expect {|b| game.turn(&b)}.to yield_with_args Turn

      game.start do
        game.turn do |turn|
          expect(turn.player.to_s).to eq "Bob"
        end
        game.turn do |turn|
          expect(turn.player.to_s).to eq "Jim"
        end
        game.turn do |turn|
          expect(turn.player.to_s).to eq "Bob"
        end
      end
    end

    it "remembers the who the last turn's player was" do
      game.start do
        game.turn {|_|}
        expect(game.player.to_s).to eq "Bob"
        game.turn {|_|}
        expect(game.player.to_s).to eq "Jim"
      end
    end

    it "keeps track of each player's score" do
      expect(game.scores).to eq({"Bob" => 0, "Jim" => 0})
      expect(game.next_player.score).to eq 0
    end
  end

  context "the full game" do
    subject(:game) {Game.new("Bob", "Jim")}

    it "won't record the score until the first time a player scores at least 300 points" do
      game.start do
        game.turn do |turn|
          turn.roll [1, 1, 3, 4, 6]
          expect(turn.score).to be < 300
          expect(turn.in_the_game?).to eq false
        end
        expect(game.player.score).to eq 0
        expect(game.player.in_the_game?).to eq false

        game.turn do |turn|
          turn.roll [1, 1, 6, 5, 5]
          expect(turn.score).to eq 300
          expect(turn.in_the_game?).to eq true
        end

        expect(game.player.score).to eq 300
        expect(game.player.in_the_game?).to eq true

      end
    end

    it "allows to play a full turn for each player" do
      Game.new("Bob", "Jim").start do
        game.turn do |turn|
          expect(turn.player.to_s).to eq "Bob"
          turn.roll [1, 1, 1, 2, 2]
          expect(turn.available_dice).to eq 2
          turn.roll [5, 2]
          expect(turn.dice_available?).to eq true
          expect(turn.score).to be 1050
        end

        expect(game.player.score).to be 1050
        expect(game.player.in_the_game?).to eq true

        game.turn do |turn|
          expect(turn.player.to_s).to eq "Jim"
          turn.roll [2, 2, 3, 3, 4]
          expect(turn.score).to be 0
          expect(turn.dice_available?).to eq false
        end

        expect(game.player.score).to be 0
        expect(game.player.in_the_game?).to eq false
      end
    end

    it "ends when a player has 3000 points and every other player had their last turn" do
      Game.new("Bob", "Jim").start do
        expect(game.ended?).to eq false

        game.turn do |turn|
          expect(turn.player.to_s).to eq "Bob"
          expect(turn.final?).to eq false
          turn.roll [2, 2, 2, 3, 5]
        end

        expect(game.ended?).to eq false
        expect(game.final_turns?).to eq false

        game.turn do |turn|
          expect(turn.player.to_s).to eq "Jim"
          expect(turn.final?).to eq false
          turn.roll [1, 1, 1, 5, 5]
          turn.roll [1, 1, 1, 1, 1]
          turn.roll [1, 1, 1, 2, 3]
        end

        expect(game.ended?).to eq false
        expect(game.final_turns?).to eq true

        game.turn do |turn|
          expect(turn.player.to_s).to eq "Bob"
          expect(turn.final?).to eq true
          turn.roll [5, 5, 5, 6, 6]
        end

        expect(game.ended?).to eq true
        expect(game.final_turns?).to eq false

        expect {game.turn}.to raise_error Game::GameEndedError
      end
    end

    it "knows who won at the end and should support ties" do
      Game.new("Bob", "Jim").start do
        expect(game.ended?).to eq false

        game.turn do |turn|
          turn.roll [2, 2, 2, 3, 5]
        end

        game.turn do |turn|
          turn.roll [1, 1, 1, 5, 5]
          turn.roll [1, 1, 1, 1, 1]
          turn.roll [1, 1, 1, 2, 3]
        end

        game.turn do |turn|
          turn.roll [5, 5, 5, 6, 6]
        end

      end

      expect(game.ended?).to eq true
      expect(game.winners).to eq ["Jim"]
    end

  end
end
