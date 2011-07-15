require "stringio"
class MockIO < StringIO
  attr_accessor :write_buffer

  def initialize(read_buf)
    super(read_buf)
    @write_buffer = ""
  end

  def write(data)
    @write_buffer.concat(data.to_s)
  end
end
