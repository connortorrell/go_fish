require 'socket'
require_relative '../lib/server'
require_relative '../lib/client'

def accept_client(client)
  server.accept_new_client
end

describe ("Server") do
  let(:server) { Server.new }
  let(:client1) { Client.new }
  let(:client2) { Client.new }

  before(:each) do
    server.start
    accept_client(client1)
    accept_client(client2)
    server.create_game_if_possible
  end

  after(:each) do
    server.stop
    client1.close
    client2.close
  end

  it "is not listening on a port before it is started"  do
    server.stop
    expect {Client.new("localhost", server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  it "starts a game correctly" do
    expect(server.games.count).to eq 1
  end

  it "gives both clients start messages" do
    expect(client1.capture_output).to eq("Game started")
    expect(client2.capture_output).to eq("Game started")
  end
end