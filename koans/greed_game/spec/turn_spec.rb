require 'turn'

RSpec.configure do |c|
  c.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

RSpec.describe Turn do
  subject(:turn) {Turn.new Player.new("Aaron")}

  context "each turn" do
    it "allows the players to roll their (5) dice" do
      expect(turn.roll.size).to eq 5
    end

    it "calculates a score for the last dice-roll" do
      turn.roll [1, 1, 1, 2, 3]
      expect(turn.dice_score).to eq 1000
      turn.roll [5,6]
      expect(turn.dice_score).to eq 50
    end

    it "keeps track of the last roll" do
      result = [1, 1, 1, 2, 3]
      turn.roll result
      expect(turn.dice).to eq result
    end

    it "keeps track of the current score" do
      turn.roll [1, 1, 1, 2, 3]
      expect(turn.score).to eq 1000
      turn.roll [5, 3]
      expect(turn.score).to eq 1050
    end

    it "keeps track of the available dice #" do
      turn.roll [1, 1, 1, 5, 3]
      expect(turn.dice_available?).to eq true
      expect(turn.available_dice).to eq 1
      expect(turn.roll.size).to eq 1
    end

    it "allows to roll again all non-scoring dice" do
      turn.roll [1, 1, 1, 2, 3]
      expect(turn.roll.size).to eq 2
    end

    it "allows to re-roll all dice if all dice score points" do
      turn.roll [3, 3, 3, 5, 5]
      expect(turn.dice_available?).to eq true
      expect(turn.available_dice).to eq 5
      expect(turn.score).to eq 400
    end

    it "allows to re-reroll all dice even if all scored points in different throws" do
      turn.roll [3, 3, 3, 4, 6]
      expect(turn.dice_available?).to eq true
      expect(turn.available_dice).to eq 2

      turn.roll [1, 5]
      expect(turn.dice_available?).to eq true
      expect(turn.available_dice).to eq 5
    end

    it "does consider a turn with no points on the dice to end with 0 points" do
      turn.roll [2, 2, 3, 3, 4]
      expect(turn.score).to eq 0
      expect(turn.dice_available?).to eq false
    end

    it "ends the turn with zero points if _any_ roll scored no points" do

      turn.roll [1, 1, 2, 2, 3]
      expect(turn.score).to eq 200
      expect(turn.dice_available?).to eq true

      turn.roll [2, 2, 3]
      expect(turn.score).to eq 0
      expect(turn.dice_available?).to eq false
    end

  end
end
