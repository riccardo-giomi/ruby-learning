# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "Score.calculate" function will be used to Score.calculate the
# Score.calculate of a single roll of the dice.
#
# A greed roll is Score.calculated as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# Score.calculate([1,1,1,5,1]) => 1150 points
# Score.calculate([2,3,4,6,2]) => 0 points
# Score.calculate([3,4,5,3,3]) => 350 points
# Score.calculate([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the Score.calculate method.

require 'score'

RSpec.configure do |c|
  c.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

RSpec.describe Score do

  it "will give zero points to zero dice" do
    expect(Score.calculate []).to be_zero
  end

  it "will give 50 points to a single roll of 5" do
    expect(Score.calculate [5]).to be 50
  end

  it "will give 100 points to a single roll of 1" do
    expect(Score.calculate [1]).to be 100
  end

  it "will give 100 points to a single roll of 1" do
    expect(Score.calculate [1]).to be 100
  end

  it "will sum the individual Score.calculates for multiple 1s and 5s" do
    expect(Score.calculate [1, 5, 5, 1]).to be 300
  end

  it "will give zero points for single 2s, 3s, 4s and 6s" do
    expect(Score.calculate [2, 3, 4, 6]).to be_zero
  end

  it "will give 1000 points for a triple 1" do
    expect(Score.calculate [1, 1, 1]).to be 1000
  end

  it "will give 100x points for other triples" do
    expect(Score.calculate [2, 2, 2]).to be 200
    expect(Score.calculate [3, 3, 3]).to be 300
    expect(Score.calculate [4, 4, 4]).to be 400
    expect(Score.calculate [5, 5, 5]).to be 500
    expect(Score.calculate [6, 6, 6]).to be 600
  end

  it "will sum the points from the different Score.calculates in a dice roll" do
    expect(Score.calculate [2, 5, 2, 2, 3]).to be 250
    expect(Score.calculate [5, 5, 5, 5]   ).to be 550
    expect(Score.calculate [1, 1, 1, 1]   ).to be 1100
    expect(Score.calculate [1, 1, 1, 1, 1]).to be 1200
    expect(Score.calculate [1, 1, 1, 5, 1]).to be 1150
  end

  it "provides the scoring and non-scoring dice sets" do
    expect {|b| Score.calculate([], &b)}.to yield_with_args(Array, Array)

    score = Score.calculate [1, 2, 3, 3, 3] do |scoring, non_scoring|
      expect(scoring).to eq [1, 3, 3, 3]
      expect(non_scoring).to eq [2]
    end

    expect(score).to be 400
  end
end
