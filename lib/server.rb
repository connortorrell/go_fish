require 'socket'
require_relative 'game'
require_relative "person"

class Server
  attr_accessor :games_to_people, :waiting_list, :server

  PLAYERS_PER_GAME = 3

  def initialize
    @games_to_people = {}
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
    if waiting_list.length == PLAYERS_PER_GAME
      players = waiting_list.map(&:player)
      game = Game.new(players)
      games_to_people[game] = waiting_list
      waiting_list = []
      send_start_messages(game)
      game
    end
  end

  def send_start_messages(game)
    puts "Game started"
    send_global_message(game, "Game started")
  end

  def capture_output(client, delay=0.1)
    sleep(delay)
    client.read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def people(game)
    games_to_people[game]
  end

  def play_full_game(game)
    game.start
    until game.winner do
      people(game).each do |person|
        play(game, person)
      end
    end
    send_global_message("Winner: #{game.winner.name}")
    close_clients(game)
  end

  def play(game, person)
    client = person.client
    player = person.player
    send_global_message("Enter the player you wou")
    client1_input=""
    client2_input=""
    until client1_input == "play" and client2_input == "play" do
      client1_input = update_client_input(clients(game).first, client1_input)
      client2_input = update_client_input(clients(game).last, client2_input)
    end
    number_of_cards = player.cards_left
    until game.play_round(player, asked_rank, asked_player) == "Go Fish"
      send_global_message(game, "#{player.name} took #{player.cards_left - number_of_cards} #{asked_rank}s from #{asked_player.name}")
    end
    send_global_message(game, "Go Fish! #{player.name} drew a card from the middle deck")
  end

  def update_client_input(client, client_input)
    if client_input == ""
      client_input = capture_output(client)
    end
    client_input
  end

  def send_global_message game, message
    people(game).each do |person|
      person.client.puts message
    end
  end

  def send_client_message game, client, message

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
