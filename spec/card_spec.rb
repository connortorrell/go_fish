require_relative '../lib/card'

describe 'Card' do
  it "returns true when checking if two cards of the same rank are equal" do
    card1 = Card.new("ace")
    card2 = Card.new("ace")
    expect(card1).to eq(card2)
    expect(card1).to_not eq(Object.new)
  end

  it "returns correct value of card" do
    card = Card.new("ace")
    expect(card.value).to eq(13)
    card2 = Card.new("10")
    expect(card2.value).to eq(9)
  end
end
