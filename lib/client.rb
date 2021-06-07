require 'socket'

class Client
  attr_reader :socket, :output

  def initialize(network, port)
    @socket = TCPSocket.new(network, port)
  end

  def provide_input(text)
    socket.puts(text)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    @output = socket.read_nonblock(1000).chomp # not gets which blocks
  rescue IO::WaitReadable
    output = ""
  end

  def close
    socket.close if socket
  end
end