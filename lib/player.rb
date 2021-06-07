require_relative "card"

class Player
  attr_reader :name, :hand

  def initialize (name, hand = [])
    @name = name
    @hand = hand
  end

  def has_card?(rank)
    hand.include?(Card.new(rank))
  end

  def give_cards(rank)
    cards = []
    hand.each do |card|
      if card.rank == rank
        cards.push(hand.delete(card))
      end
    end
    cards
  end

  def cards_left
    hand.count
  end

  def take_cards (cards)
    hand.concat(cards)
  end

  def books
    rank_frequency = {}
    hand.each do |card|
      if rank_frequency.key?(card.rank)
        rank_frequency[card.rank] += 1
      else
        rank_frequency[card.rank] = 1
      end
    end
    rank_frequency.values.count(4)
  end
end