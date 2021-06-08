require_relative "../lib/round"
require_relative "../lib/card_deck"

describe 'Round' do
  let(:server) { Server.new }
  let(:person1) { Person.new(Client.new.socket, Player.new("Connor", [Card.new("ace")])) }
  let(:person2) { Person.new(Client.new.socket, Player.new("Jake", [Card.new("ace"), Card.new("ace"), Card.new("queen")])) }
  let(:round) { Round.new(CardDeck.new, person1, [person2]) }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    person1.client.close
    person2.client.close
  end

  it "gives ace from asked player to asking player" do
    round.ask(person2, "ace")
    expect(person1.player.cards_left).to eq(3)
    expect(person2.player.cards_left).to eq(1)
  end

  it "gives asking player a card from the deck when asked player does not have the rank asked for" do
    round.ask(person2, "jack")
    expect(person1.player.cards_left).to eq(2)
    expect(person2.player.cards_left).to eq(3)
  end
end 