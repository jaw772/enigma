require_relative './modules/offsets'
require_relative './modules/keys'

require 'date'
class Enigma
  include Offsets
  include Keys

  def initialize
    @shift_counter = -1
    @letters = [*'a'..'z',' ']
    @shift_array = []
    @dd = Date.today

  end

  def shifts(offset_hash, shift_array)
    @shift_counter = -1
    @shift_array = shift_array
    offset_hash.values.each do |offset|
      @shift_counter += 1
      @shift_array[@shift_counter] += offset
    end
  end

  def encrypt(message, key = random_key, date = @dd.strftime("%d%m%y"))
    @enigma_hash = {
      key: key,
      date: date
    }
    @shift_counter = -1
    key_hash = self.create_keys(key)
    offset_hash = self.create_offset(date)
    shift_array = key_hash.values
    message = message.downcase
    shifts(offset_hash, shift_array)
    coded_msg = ""
    message_array = message.chars
    message_array.each do |char|
      if @letters.include?(char) == true
        int = @letters.index(char)
        if @shift_counter == 3
          @shift_counter = -1
        end
        @shift_counter += 1
        rotate_counter = (int + @shift_array[@shift_counter])
        rotated_letters = @letters.rotate(rotate_counter)
        coded_msg.concat(rotated_letters[0])
      else
        coded_msg.concat(char)
      end
    end
    @enigma_hash[:encryption] = coded_msg
    @enigma_hash
  end

  def decrypt(message, key = random_key, date = @dd.strftime("%d%m%y"))
    @enigma_hash = {
      key: key,
      date: date
    }
    @shift_counter = -1
    key_hash = self.create_keys(key)
    offset_hash = self.create_offset(date)
    shift_array = key_hash.values
    message = message.downcase
    shifts(offset_hash, shift_array)
    coded_msg = ""
    message_array = message.chars
    message_array.each do |char|
      if @letters.include?(char) == true
        int = @letters.index(char)
        if @shift_counter == 3
          @shift_counter = -1
        end
        @shift_counter += 1
        rotate_counter = (int - @shift_array[@shift_counter])
        rotated_letters = @letters.rotate(rotate_counter)
        coded_msg.concat(rotated_letters[0])
      else
        coded_msg.concat(char)
      end
    end
    @enigma_hash[:decryption] = coded_msg
    @enigma_hash
  end

  def random_key
    rand.to_s[2..6]
  end
end
