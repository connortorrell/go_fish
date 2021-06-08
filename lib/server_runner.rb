require_relative 'server'

server = Server.new
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