class Person
  attr_reader :client, :player

  def initialize(client, player)
    @client = client
    @player = player
  end
end