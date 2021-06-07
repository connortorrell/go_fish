require 'socket'
require_relative '../lib/server'
require_relative '../lib/client'

describe ("Server") do

  def accept_client(client, name)
    @clients.push(client)
    @server.accept_new_client(name)
    @game = @server.create_game_if_possible
  end

  def start_server
    @server = Server.new
    @server.start
  end

  before(:each) do
    @clients = []
    start_server
    @client1 = Client.new("localhost", @server.port_number)
    accept_client(@client1, "Player 1")
    @client2 = Client.new("localhost", @server.port_number)
    accept_client(@client2, "Player 2")
    @client3 = Client.new("localhost", @server.port_number)
    accept_client(@client3, "Player 3")
    @game.start
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  it "is not listening on a port before it is started"  do
    @server.stop
    expect {Client.new("localhost", @server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  it "starts a game correctly" do
    expect(@server.games_to_people.count).to be 1
  end

  it "gives both clients start messages" do
    expect(@client1.capture_output).to eq("Game started")
    expect(@client2.capture_output).to eq("Game started")
  end
end