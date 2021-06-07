class Round
  attr_reader :deck, :asking_player, :asked_rank, :asked_player

  def initialize(deck, asking_player, asked_rank, asked_player)
    @deck = deck
    @asking_player = asking_player
    @asked_rank = asked_rank
    @asked_player = asked_player
  end

  def play
    if asked_player.has_card?(asked_rank)
      asking_player.take_cards(asked_player.give_cards(asked_rank))
    else
      asking_player.take_cards([deck.deal])
    end
  end
end