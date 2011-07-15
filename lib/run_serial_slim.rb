require "serial_slim"
require 'serialport'
require 'socket_service'

include SerialSlim

def run(port, device, baud_rate)
	@connected = true
  socket_service = SocketService.new()
  puts "Device #{device} at #{baud_rate}"
  serial_port = SerialPort.new device, baud_rate

	socket_service.serve(port) do  |socket|
    begin
      puts "Serving new connection #{socket}"
      serve_serial_slim(socket, serial_port)
      @connected = false
    rescue Exception => e
      puts e
      puts e.backtrace
      @connected = false
    end
  end

	while (@connected)
    sleep(0.1)
	end

  socket_service.close
	exit(0)
end

DEVICE = "/dev/tty.usbserial-11CP0620"
BAUD_RATE = 9600

begin
  device, baud_rate, port = *ARGV
  run(port.to_i, device, baud_rate.to_i)
rescue Exception => e
  puts e
  puts e.backtrace
  STDOUT.flush
  exit(-666)
end
