class Person
  attr_reader :name, :player, :client

  def initialize(client, name)
    @client = client
    @name = name
    @player = Player.new(name)
  end
end