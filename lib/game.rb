require_relative "card_deck"
require_relative "round"

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

  def play
    people.each do |person|
      other_people = people - [person]
      round = Round.new(deck, person, other_people)
      result = round.play
      until result.include?("Go Fish!") do
        send_global_message(result)
        result = round.play
      end
      send_global_message(result)
    end
  end

  def send_global_message(message)
    clients.each do |client|
      client.puts message
    end
  end

  def close_clients
    clients.each do |client|
      client.close
    end
  end
end