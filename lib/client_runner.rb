require_relative 'client'

print "Enter the network: "
network = gets.chomp
print "Enter the port number: "
port_number = gets.chomp.to_i
client = Client.new(network, port_number)
while true do
  puts "Waiting for updates"
  output = ""
  until output != ""
    output = client.capture_output
  end
  puts output
  if output.include?(":")
    client.provide_input(gets.chomp)
  end
end