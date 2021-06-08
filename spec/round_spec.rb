require_relative "../lib/round"
require_relative "../lib/card_deck"

describe 'Round' do
  let(:server) { Server.new }
  let(:person1) { Person.new(Client.new.socket, Player.new("Connor", [Card.new("ace"), Card.new("ace")])) }
  let(:person2) { Person.new(Client.new.socket, Player.new("Jake", [Card.new("ace"), Card.new("ace")])) }
  let(:round) { Round.new(CardDeck.new, person1, [person2]) }

  before(:each) do
    server.start
  end

  after(:each) do
    server.stop
    person1.client.close
    person2.client.close
  end

  it "gives ace from asked_player to asking_player" do
    round.ask(person2, "ace")
    expect(person1.player.cards_left).to eq(4)
    expect(person1.player.books).to eq(1)
    expect(person2.player.cards_left).to eq(0)
  end

  it "gives asking_player a card from the deck when asked_player does not have the rank asked for" do
    round.ask(person2, "jack")
    expect(person1.player.cards_left).to eq(3)
    expect(person1.player.books).to eq(0)
    expect(person2.player.cards_left).to eq(2)
  end
end 