require_relative './modules/offsets'
require_relative './modules/keys'
class Encrypt
  include Offsets
  include Keys
  def initialize(message, key, date)
    @message = message.downcase
    @key = key
    @date = date
    @key_hash = self.create_keys(key)
    @offset_hash = self.create_offset(date)
    @shifts = @key_hash.values
    @letters = [*'a'..'z',' ']
    @enigma_hash = {
      key: @key,
      date: @date
    }
  end

  def shifts
    shift = -1
    @offset_hash.values.each do |offset|
      shift += 1
      @shifts[shift] += offset
    end
  end

  def encrypts
    shifts
    shift = -1
    coded_msg = ""
    message_array = @message.chars
    message_array.each do |char|
      if @letters.include?(char) == true
        int = @letters.index(char)
        if shift == 3
          shift = -1
        end
        shift += 1
        @mm = @shifts[shift] + int
        e = @letters.rotate(@mm)
        coded_msg.concat(e[0])
      else
        coded_msg.concat(char)
      end

    end
    @enigma_hash[:encryption] = coded_msg
    @enigma_hash
  end
end

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
