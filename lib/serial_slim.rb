module SerialSlim
  def read_message(com)
    length = com.read(6)
    return nil unless length
    colon = com.read(1)
    command = com.read(length.to_i)
    "#{length}:#{command}"
  end

  def serve_serial_slim(fitnesse, remote_slim)
    f = File.open("slimlog.txt", "a")
    puts "Getting remote Slim Version"
    version = remote_slim.gets
    puts ("Remote Slim Version: #{version}")
    fitnesse.puts(version)
    fitnesse.flush

    said_bye = false
    while !said_bye
      message = read_message(fitnesse)
      f.puts " >>> #{message}"
      if message
        remote_slim.write(message)
        remote_slim.flush

        if message.downcase == "000003:bye"
          puts "Goodbye from Serial Slim"
          said_bye = true
        else
          response = read_message(remote_slim)
          f.puts " <<< #{response}"
          fitnesse.write(response)
          fitnesse.flush
        end
      end
    end
    f.puts("Finished")
    f.close
  end
end
