require 'slim_bridge_server'
require 'socket'

remote_host, remote_port, port = *ARGV
SlimBridgeServer::run(port, TCPSocket.open(remote_host, remote_port))

