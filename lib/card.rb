class Card
  attr_reader :rank, :suit

  CARD_VALUES = {
    "2" => 1,
    "3" => 2,
    "4" => 3,
    "5" => 4,
    "6" => 5,
    "7" => 6,
    "8" => 7,
    "9" => 8,
    "10" => 9,
    "J" => 10,
    "Q" => 11,
    "K" => 12,
    "A" => 13
  }

  def initialize (rank, suit)
    @rank = rank
    @suit = suit
  end

  def == card
    card.class == self.class && self.rank == card.rank && self.suit == card.suit
  end

  def value
    CARD_VALUES[self.rank]
  end
end