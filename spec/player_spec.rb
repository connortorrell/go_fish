require_relative '../lib/player'

describe 'Player' do
  let(:player) { Player.new("Connor", [Card.new("ace"), Card.new("ace"), Card.new("ace"), Card.new("ace")]) }

  it "gives an ace" do
    expect(player.give_cards("ace")).to eq([Card.new("ace")])
    expect(player.has_card?("ace")).to eq(false)
  end

  it "takes cards won and adds to bottom of hand" do
    player = Player.new("Connor")
    card1 = Card.new("5")
    card2 = Card.new("10")
    player.take_cards([card1, card2])
    expect(player.cards_left).to eq(2)
  end

  it "returns number of cards left" do
    expect(player.cards_left).to eq(4)
  end

  it "returns number of books" do
    expect(player.books).to eq(1)
  end
end
