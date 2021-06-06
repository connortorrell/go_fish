require_relative '../lib/card'

describe 'Card' do
  it "returns true when checking if two of the same cards are equal" do
    card1 = Card.new("A", "H")
    card2 = Card.new("A", "H")
    expect(card1).to eq(card2)
    expect(card1).to_not eq(Object.new)
  end

  it "returns correct value of card" do
    card = Card.new("A", "H")
    expect(card.value).to eq(13)
    card2 = Card.new("10", "S")
    expect(card2.value).to eq(9)
  end
end
