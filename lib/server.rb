require 'socket'
require_relative 'game'
require_relative "person"
require_relative "player"

class Server
  attr_accessor :games, :waiting_list, :server

  PLAYERS_PER_GAME = 3

  def initialize
    @games = []
    @waiting_list = []
  end

  def port_number
    3336
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(player_name = "Player #{waiting_list.length + 1}")
    client = server.accept_nonblock
    player = Player.new(player_name)
    add_person_to_waiting_list(client, player)
  rescue IO::WaitReadable, Errno::EINTR
  end

  def add_person_to_waiting_list(client, player)
    waiting_list.push(Person.new(client, player))
  end

  def create_game_if_possible
    if waiting_list.count > 1
      game = Game.new(waiting_list)
      games.push(game)
      self.waiting_list = []
      send_start_messages(game)
      game
    end
  end

  def send_start_messages(game)
    puts "Game started"
    send_message(game, "Game started")
  end

  def capture_output(client, delay=0.1)
    sleep(delay)
    client.read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def play_full_game(game)
    game.start
    until game.winner do
      game.play
    end
    send_message("Winner: #{game.winner.name}")
    close_clients(game)
  end

  def update_client_input(client, client_input)
    if client_input == ""
      client_input = capture_output(client)
    end
    client_input
  end

  def send_message game, message
    game.people.each do |person|
      person.client.puts message
    end
  end

  def stop
    server.close if server
  end

  def close_clients(game)
    people(game).each do |person|
      person.client.close
    end
  end
end
