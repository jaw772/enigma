message_file = File.open(ARGV[0], "r")
key_1 = "82648"
date_1 = "240818"
incoming_message = message_file.read
message_file.close
crypt = Encrypt.new(incoming_message, key_1, date_1)
encrypted = crypt.encrypts
encrypted_message = encrypted[:encryption]
encrypted_file = File.open(ARGV[1], "w")
encrypted_file.write(encrypted_message)
encrypted_file.close
puts "Created '#{ARGV[1]}' with the key #{key_1} and date #{date_1}"
