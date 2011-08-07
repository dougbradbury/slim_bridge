require 'serialport'
require 'slim_bridge_server'


def run_tcp(fitnese_port, remote_host, remote_port)
  run_server(port, TcpSocket.new(remote_host, remote_port))
end


  device, baud_rate, port = *ARGV
  SlimBridgeServer::run(port, SerialPort.new(device, baud_rate.to_i))
