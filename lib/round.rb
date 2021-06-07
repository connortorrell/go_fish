class Round
  attr_reader :deck, :current_player, :other_players

  def initialize(deck, current_player, other_players)
    @deck = deck
    @current_player = current_player
    @other_players = other_players
  end

  def play
    if asked_player.has_card?(asked_rank)
      asking_player.take_cards(asked_player.give_cards(asked_rank))
    else
      asking_player.take_cards([deck.deal])
      "Go Fish"
    end
  end
end 