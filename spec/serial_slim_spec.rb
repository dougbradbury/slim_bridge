$: << File.join(File.dirname(__FILE__), "..", "lib")
$: << File.dirname(__FILE__)
require "serial_slim.rb"
require "mock_io.rb"
include SerialSlim

describe SerialSlim do
  it "should read a message" do
    com = StringIO.new("000003:abcblahblahblah")
    read_message(com).should == "000003:abc"
  end

  it "should forward messages from socket to serial port" do
    serial_port = MockIO.new "Slim -- V0.1\n"
    socket = MockIO.new("000003:bye")
    serve_serial_slim(socket, serial_port)
    socket.write_buffer.should == "Slim -- V0.1\n"
    serial_port.write_buffer.should == "000003:bye"
  end

  it "should forward responses" do
    serial_port = MockIO.new "Slim -- V0.1\n000005:asdfg"
    socket = MockIO.new("000006:people000003:bye")
    serve_serial_slim(socket, serial_port)
    socket.write_buffer.should == "Slim -- V0.1\n000005:asdfg"
    serial_port.write_buffer.should == "000006:people000003:bye"

  end
end
