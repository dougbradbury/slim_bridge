require 'serialport'
require 'slim_bridge_server'

device, baud_rate, port = *ARGV[0..2]
SlimBridgeServer::run(port, SerialPort.new(device, baud_rate.to_i))
