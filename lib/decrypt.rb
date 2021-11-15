message_file = File.open(ARGV[0], "r")
key_1 = "82648"
date_1 = "240818"
message_text = message_file.read
message_file.close
crypt = Decrypt.new(text, key_1, date_1)
decrypted = crypt.decrypts
decrypted_message = decrypted[:decryption]
decrypted_file = File.open(ARGV[1], "w")
decrypted_file.write(decrypted_message)
decrypted_file.close
puts "Created '#{ARGV[1]}' with the key #{key_1} and date #{date_1}"
