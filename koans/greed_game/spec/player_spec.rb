require 'player'

RSpec.configure do |c|
  c.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end

RSpec.describe Player do
  subject(:player) {Player.new "Jin"}

  it "has a name" do 
    expect(player.name).to eq "Jin"
  end

  it "has information about a player current status in the game" do
    player.score      = 1337
    player.done       = true
    player.final_turn = false
    expect(player.score).to eq 1337
    expect(player.done).to eq true
    expect(player.final_turn).to eq false
  end

  it "provides quick info on player's status" do
    expect(player.inspect).to eq "Jin: 0"
  end
end
