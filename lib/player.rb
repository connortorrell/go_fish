class Player
  attr_reader :name, :hand

  def initialize (name, hand = [])
    @name = name
    @hand = hand
  end

  def play_card
    hand.pop
  end

  def cards_left
    hand.count
  end

  def take_cards (cards)
    hand.unshift(cards).flatten!
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