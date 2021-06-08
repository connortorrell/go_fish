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
    send_message(current_person, "Who would you like to fish from: ")
    person_name = ""
    until person_name != "" do
      person_name = capture_output(current_person)
    end
    send_message(current_person, "What card would you like to fish: ")
    rank = ""
    until rank != "" do
      rank = capture_output(current_person)
    end
    person = other_people.find { |other_person| other_person.player.name == person_name}
    ask(person, rank)
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
      "Go Fish! #{current_player.name} drew a card from the deck"
    end
  end
end 