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
end
