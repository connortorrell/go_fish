class Card
  attr_reader :rank

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
    "jack" => 10,
    "queen" => 11,
    "king" => 12,
    "ace" => 13
  }

  def initialize (rank)
    @rank = rank
  end

  def == card
    card.class == self.class && self.rank == card.rank
  end

  def value
    CARD_VALUES[self.rank]
  end
end