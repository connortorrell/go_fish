require_relative "../lib/game"

describe 'Game' do
  let(:game) { Game.new([Player.new("Connor"), Player.new("Jake"), Player.new("Matthew")]) }

  it "deals 7 cards to 3 players" do
    game.start
    expect(game.players[0].cards_left).to eq(7)
    expect(game.players[1].cards_left).to eq(7)
    expect(game.players[2].cards_left).to eq(7)
  end

  it "deals 5 cards to 4 players" do
    game = Game.new([Player.new("Connor"), Player.new("Jake"), Player.new("Matthew"), Player.new("Brianna")])
    game.start
    expect(game.players[0].cards_left).to eq(5)
    expect(game.players[1].cards_left).to eq(5)
    expect(game.players[2].cards_left).to eq(5)
    expect(game.players[3].cards_left).to eq(5)
  end
end