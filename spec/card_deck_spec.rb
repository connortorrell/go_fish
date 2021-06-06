require_relative '../lib/card_deck'

describe 'CardDeck' do
  let(:deck) { CardDeck.new }

  it 'has 52 cards when created' do
    expect(deck.cards_left).to eq 52
  end

  it 'deals the top card' do
    card = deck.deal
    expect(deck.cards_left).to eq 51
  end

  it "shuffles the deck" do
    top_card = deck.deal
    deck2 = CardDeck.new
    new_top_card = deck2.deal
    expect(new_top_card).to_not(eq(top_card), "unlucky")
  end
end
