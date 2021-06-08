require 'socket'

class Client
  attr_reader :socket

  def initialize(network = "localhost", port = 3336)
    @socket = TCPSocket.new(network, port)
  end

  def provide_input(text)
    socket.puts(text)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    socket.read_nonblock(1000).chomp # not gets which blocks
  rescue IO::WaitReadable
    ""
  end

  def close
    socket.close if socket
  end
end