require_relative "../lib/game"

describe 'Game' do
  before(:each) do
    @game = Game.new([Player.new("Connor"), Player.new("Jake"), Player.new("Matthew")])
    @game.start
  end

  it "deals 7 cards to 3 players" do
    expect(@game.players[0].cards_left).to eq(7)
    expect(@game.players[1].cards_left).to eq(7)
    expect(@game.players[2].cards_left).to eq(7)
  end

  it "deals 5 cards to 4 players" do
    game = Game.new([Player.new("Connor"), Player.new("Jake"), Player.new("Matthew"), Player.new("Brianna")])
    game.start
    expect(game.players[0].cards_left).to eq(5)
    expect(game.players[1].cards_left).to eq(5)
    expect(game.players[2].cards_left).to eq(5)
    expect(game.players[3].cards_left).to eq(5)
  end

  it "gives ace from asked_player to asking_player" do
    asking_player = Player.new("Connor", [Card.new("ace"), Card.new("ace"), Card.new("ace")])
    asked_rank = "ace"
    asked_player = Player.new("Matthew", [Card.new("ace")])
    @game.play_round(asking_player, asked_rank, asked_player)
    expect(asking_player.cards_left).to eq(4)
    expect(asking_player.books).to eq(1)
    expect(asked_player.cards_left).to eq(0)
  end

  it "gives asking_player a card from the deck when asked_player does not have the rank asked for" do
    asking_player = Player.new("Connor", [Card.new("ace"), Card.new("ace"), Card.new("ace")])
    asked_rank = "ace"
    asked_player = Player.new("Matthew", [Card.new("jack")])
    @game.play_round(asking_player, asked_rank, asked_player)
    expect(asking_player.cards_left).to eq(4)
    expect(asking_player.books).to eq(0)
    expect(asked_player.cards_left).to eq(1)
  end
end