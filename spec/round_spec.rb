require_relative "../lib/round"
require_relative "../lib/card_deck"

describe 'Round' do
  it "gives ace from asked_player to asking_player" do
    round = Round.new(CardDeck.new, Player.new("Connor", [Card.new("ace"), Card.new("ace")]), [Player.new("Matthew", [Card.new("ace"), Card.new("ace")])])
    round.play
    expect(round.asking_player.cards_left).to eq(4)
    expect(round.asking_player.books).to eq(1)
    expect(round.asked_player.cards_left).to eq(0)
  end

  it "gives asking_player a card from the deck when asked_player does not have the rank asked for" do
    round = Round.new(CardDeck.new, Player.new("Connor", [Card.new("ace"), Card.new("ace"), Card.new("ace")]), "ace", Player.new("Matthew", [Card.new("jack")]))
    round.play
    expect(round.asking_player.cards_left).to eq(4)
    expect(round.asking_player.books).to eq(0)
    expect(round.asked_player.cards_left).to eq(1)
  end
end 