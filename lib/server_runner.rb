require_relative 'server'

print "Port number: "
port_number = gets.chomp.to_i
print "Number of players: "
number_of_players = gets.chomp.to_i
server = Server.new(port_number, number_of_players)
server.start
while true do
  server.accept_new_client
  game = server.create_game_if_possible
  if game
    Thread.new(game) do |game|
      server.play_full_game(game)
    end
  end
end