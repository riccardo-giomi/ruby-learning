require 'dice_set'

RSpec.configure do |c|
  c.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

RSpec.describe DiceSet do

  subject(:dice) {DiceSet.new}

  it "can create a dice set" do
    expect(dice).to_not be_nil
  end

  context "rolling the dice" do
    it "returns a set of integers between 1 and 6" do
      dice.roll 5

      expect(dice.values).to be_an Array
      expect(dice.values.size).to be 5
      expect(dice.values).to all(be_between 1, 6)
    end

    it "the number of dice to roll can be chosen" do
    dice.roll 3
    expect(dice.values.size).to be 3

    dice.roll 1
    expect(dice.values.size).to be 1
    end
  end

  context "values "  do
    it "do not change unless explicitly rolled" do
      dice.roll 5
      first_time = dice.values
      second_time = dice.values
      expect(first_time).to eq second_time
    end

    it "change between rolls" do
      dice.roll(5)
      first_time = dice.values

      dice.roll(5)
      second_time = dice.values
      expect([first_time, first_time.object_id]).to_not eq [second_time, second_time.object_id]
    end
  end
end
