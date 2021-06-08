require_relative 'client'

print "Enter the network: "
network = gets.chomp
print "Enter the port number: "
port_number = gets.chomp.to_i
client = Client.new(network, port_number)
while true do
  puts "Waiting for other player"
  output = ""
  until output != ""
    output = client.capture_output
  end
  print output
  client.provide_input(gets.chomp)
end