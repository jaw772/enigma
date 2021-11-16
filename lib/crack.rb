require_relative './enigma'


encrypted_file = File.open(ARGV[0], "r")
key_1 = "82648"
date_1 = ARGV[2]
encrypted_message = encrypted_file.read
encrypted_file.close
enigma = Enigma.new
cracked = enigma.crack(encrypted_message, date_1)
cracked_message = cracked[:decryption]
cracked_file = File.open(ARGV[1], "w")
cracked_file.write(cracked_message)
cracked_file.close
puts "Created '#{ARGV[1]}' with the key #{key_1} and date #{date_1}"
