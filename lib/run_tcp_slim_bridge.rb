require 'slim_bridge_server'

device, baud_rate, port = *ARGV
run_server(port, TcpSocket.new(remote_host, remote_port))

