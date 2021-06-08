require_relative "../lib/round"
require_relative "../lib/card_deck"

describe 'Round' do
  let(:server) { Server.new }
  let(:round) { Round.new([Person.new(Client.new, Player.new("Connor", [Card.new("ace"), Card.new("ace")])), Person.new(Client.new, Player.new("Jake", [Card.new("ace"), Card.new("ace")]))]) }

  before(:each) do
    server.start
    round.play
  end

  after(:each) do
    server.stop
    game.close_clients
  end

  it "gives ace from asked_player to asking_player" do
    round.ask()
    expect(round.current_person.player.cards_left).to eq(4)
    expect(round.asking_player.books).to eq(1)
    expect(round.asked_player.cards_left).to eq(0)
  end

  it "gives asking_player a card from the deck when asked_player does not have the rank asked for" do
    expect(round.asking_player.cards_left).to eq(4)
    expect(round.asking_player.books).to eq(0)
    expect(round.asked_player.cards_left).to eq(1)
  end
end 