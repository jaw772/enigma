require_relative './modules/offsets'
require_relative './modules/keys'

class Encrypt
  include Offsets
  include Keys
  def initialize(message, key, date)
    @message = message
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
      int = @letters.index(char)
      if shift == 3
        shift = -1
      end
      shift += 1
      @mm = @shifts[shift] + int
      e = @letters.rotate(@mm)
      coded_msg.concat(e[0])
    end
    @enigma_hash[:encryption] = coded_msg
    @enigma_hash
    end
  end
