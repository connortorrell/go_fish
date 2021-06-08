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

  def play
    other_people.each_with_index do |person, i|
      send_message(current_person, "#{i + 1}. #{person.player.name}")
    end
    send_message(current_person, "Enter the number of the person you would like to fish from: ")
    person_number = ""
    until person_number != "" do
      person_number = capture_output(current_person)
    end
    person = other_people[person_number.to_i - 1]
    current_person.player.hand.each_with_index do |card, i|
      send_message(current_person, "#{i + 1}. #{card.rank}")
    end
    send_message(current_person, "Enter the number of the card would you like to fish: ")
    card_number = ""
    until card_number != "" do
      card_number = capture_output(current_person)
    end
    card = current_person.player.hand[card_number.to_i - 1]
    ask(person, card.rank)
  end

  def ask(person, rank)
    player = person.player
    current_player = current_person.player
    if player.has_card?(rank)
      cards = player.give_cards(rank)
      current_player.take_cards(cards)
      "#{current_player.name} took #{cards.count} #{rank}s from #{player.name}"
    else
      current_player.take_cards([deck.deal])
      "Go Fish! #{current_player.name} unsuccessfully fished for a #{rank} and drew a card from the deck"
    end
  end
end 