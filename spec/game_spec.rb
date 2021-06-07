require_relative "../lib/game"

describe 'Game' do
  let(:server) { Server.new }
  let(:game) { Game.new([Person.new(Client.new, Player.new("Connor")), Person.new(Client.new, Player.new("Jake")), Person.new(Client.new, Player.new("Matthew"))]) }

  before(:each) do
    server.start
    game.start
  end

  after(:each) do
    server.stop
    game.close_clients
  end

  it "deals 7 cards to 3 players" do
    expect(game.players[0].cards_left).to eq(7)
    expect(game.players[1].cards_left).to eq(7)
    expect(game.players[2].cards_left).to eq(7)
  end

  it "deals 5 cards to 4 players" do
    game = Game.new([Person.new(Client.new, Player.new("Connor")), Person.new(Client.new, Player.new("Jake")), Person.new(Client.new, Player.new("Matthew")), Person.new(Client.new, Player.new("Brianna"))])
    game.start
    expect(game.players[0].cards_left).to eq(5)
    expect(game.players[1].cards_left).to eq(5)
    expect(game.players[2].cards_left).to eq(5)
    expect(game.players[3].cards_left).to eq(5)
  end
end