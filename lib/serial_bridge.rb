
 require 'rubygems'
 require 'serialport'
 require File.join(File.dirname(__FILE__), "socket_service")

def run(port)
  puts "serial bridge running"
	@connected = true
  socket_service = SocketService.new()

	socket_service.serve(port) do  |socket|
    serve_slim_bridge(socket)
  end

	while (@connected)
    sleep(0.1)
	end
	
	puts "Goodbye"	
	STDOUT.flush
	exit(0)
end

def read_message(com)
  length = com.read(6)
  puts "Length #{length}"
  colon = com.read(1); #skip colon
  puts "Colon: #{colon} reading #{length.to_i}"
  command = com.read(length.to_i);
  "#{length}:#{command}"
end


def serve_slim_bridge(socket)
  puts "new connection"
  sp = SerialPort.new "/dev/tty.usbserial-11CP0620", 9600
  version = sp.gets
  puts ("Version #{version}")
  socket.puts(version)
  socket.flush

  said_bye = false
  while !said_bye
    puts "Reading from socket"
    message = read_message(socket)
    puts ("Read from fitnesse:  #{message}")
    # sp.write(message)
    # sp.flush

    # response = read_message(sp)
    # puts "Read from arduino #{response}"
    # response = "000000:"
    # socket.write(response)
    # socket.flush
    
    if message.downcase == "003:bye"
      puts "Goodbye"
      said_bye = true
    end
  end
  @connected = false  
end

begin
  run(ARGV[0].to_i)
rescue Exception => e
  puts e
  puts e.backtrace
  STDOUT.flush
  exit(-666)
end
