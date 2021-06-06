require_relative "card"

class CardDeck
  attr_reader :cards

  def initialize
    @cards = []
    build_deck
    shuffle
  end

  def build_deck
    suits = ["S", "C", "D", "H"]
    ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    suits.each do |suit|
      ranks.each do |rank|
        cards.push(Card.new(rank, suit))
      end
    end
  end

  def cards_left
    cards.count
  end

  def deal
    cards.pop
  end

  def shuffle
    cards.shuffle!
  end
end