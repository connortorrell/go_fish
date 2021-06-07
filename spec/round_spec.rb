require_relative "../lib/round"
require_relative "../lib/card_deck"

describe 'Round' do
  let(:round) { Round.new(CardDeck.new, Player.new("Connor", [Card.new("ace")]), "ace", Player.new("Matthew", [Card.new("ace")])) }

  it "gives ace from asked_player to asking_player" do
    round.play
    expect(round.asking_player.cards_left).to eq(2)
    expect(round.asking_player.has_card?("ace")).to eq(true)
    expect(round.asked_player.cards_left).to eq(0)
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