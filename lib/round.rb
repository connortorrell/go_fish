class Round
  attr_reader :deck, :current_person, :other_people

  def initialize(deck, current_person, other_people)
    @deck = deck
    @current_person = current_person
    @other_people = other_people
  end

  def capture_output(person, delay=0.1)
    sleep(delay)
    person.client.read_nonblock(1000).chomp
  rescue IO::WaitReadable
    ""
  end

  def send_message person, message
    person.client.puts message
  end

  def get_response
    response = ""
    until response != "" do
      response = capture_output(current_person)
    end
    response
  end

  def ask_for_player_to_fish
    send_message(current_person, "Players to fish from:")
    other_people.each_with_index do |person, i|
      send_message(current_person, "#{i + 1}. #{person.player.name}")
    end
    send_message(current_person, "Enter the number of the person you would like to fish from: ")
    other_people[get_response.to_i - 1]
  end

  def ask_for_card_to_fish
    send_message(current_person, "Cards to fish:")
    current_person.player.hand.each_with_index do |card, i|
      send_message(current_person, "#{i + 1}. #{card.rank}")
    end
    send_message(current_person, "Enter the number of the card you would like to fish: ")
    current_person.player.hand[get_response.to_i - 1]
  end

  def play
    person_to_fish = ask_for_player_to_fish
    card_to_fish = ask_for_card_to_fish
    ask(person_to_fish, card_to_fish.rank)
  end

  def ask(person, rank)
    fished_player = person.player
    current_player = current_person.player
    if fished_player.has_card?(rank)
      fish_cards(current_player, fished_player, rank)
    else
      draw_from_deck(current_player, rank)
    end
  end

  def fish_cards(current_player, fished_player, rank)
    cards = fished_player.give_cards(rank)
    current_player.take_cards(cards)
    output = "#{current_player.name} took #{cards.count} #{rank}s from #{fished_player.name}"
  end

  def draw_from_deck(player, fished_rank)
    player.take_cards([deck.deal])
    output = "Go Fish! #{player.name} unsuccessfully fished for a #{fished_rank} and drew a card from the deck"
  end
end 