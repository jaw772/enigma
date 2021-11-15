require_relative './modules/offsets'
require_relative './modules/keys'

class Decrypt
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

  def decrypts
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
        @mm = (int - @shifts[shift])
        e = @letters.rotate(@mm)
        coded_msg.concat(e[0])
      else
        coded_msg.concat(char)
      end

    end
    @enigma_hash[:decryption] = coded_msg
    @enigma_hash
    end
  end

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
