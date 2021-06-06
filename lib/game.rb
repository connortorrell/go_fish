require_relative "card_deck"

class Game
  attr_reader :players, :deck

  def initialize(players)
    @players = players
    @deck = CardDeck.new
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
        player.take_cards(deck.deal)
      end
    end
  end
end