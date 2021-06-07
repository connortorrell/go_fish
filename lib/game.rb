require_relative "card_deck"

class Game
  attr_reader :people, :deck

  def initialize(people)
    @people = people
    @deck = CardDeck.new
  end

  def players
    people.map(&:player)
  end

  def clients
    people.map(&:client)
  end

  def start
    if players.count > 3
      deal_cards(5)
    else
      deal_cards(7)
    end
  end

  def deal_cards(number_of_cards)
    number_of_cards.times do |i|
      players.each do |player|
        player.take_cards([deck.deal])
      end
    end
  end

  def play()
    game.people.each do |person|
      game.play(game, person)
    end
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

  def close_clients
    people.each do |person|
      person.client.close
    end
  end
end