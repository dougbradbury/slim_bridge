require 'socket_service'
require "slim_bridge"

module SlimBridgeServer
  def self.run(port, remote_slim)
    @connected = true
    socket_service = SocketService.new()
    socket_service.serve(port) do  |socket|
      puts "Serving new connection #{socket}"
      SlimBridge.serve(socket, remote_slim)
      @connected = false
    end

    while (@connected)
      sleep(0.1)
    end

    socket_service.close
  end
end
