require 'socket'
require_relative '../lib/server'
require_relative '../lib/client'

def accept_client(client)
  clients.push(client)
  server.accept_new_client
end

describe ("Server") do
  let(:server) { Server.new }
  let(:clients) { [] }
  let(:client1) { Client.new }
  let(:client2) { Client.new }
  let(:client3) { Client.new }

  before(:each) do
    server.start
    accept_client(client1)
    accept_client(client2)
    accept_client(client3)
    server.create_game_if_possible
  end

  after(:each) do
    server.stop
    clients.each do |client|
      client.close
    end
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