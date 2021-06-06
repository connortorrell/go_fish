require_relative '../lib/player'

describe 'Player' do
  let(:player) { Player.new("Connor", [Card.new("A", "H"), Card.new("K", "D")]) }

  it "plays card from top" do
    expect(player.play_card).to eq(Card.new("K", "D"))
  end

  it "takes cards won and adds to bottom of hand" do
    player.play_card
    player.play_card
    card1 = Card.new("5", "S")
    card2 = Card.new("10", "C")
    player.take_cards([card1, card2])
    expect(player.play_card).to eq(card2)
    expect(player.play_card).to eq(card1)
  end

  it "returns number of cards left" do
    expect(player.cards_left).to eq(2)
  end
end
