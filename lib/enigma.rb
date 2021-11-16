require_relative './modules/offsets'
require_relative './modules/keys'

require 'date'
class Enigma
  include Offsets
  include Keys

  def initialize
    @shift_counter = -1
    @letters = [*'a'..'z',' ']
    @dd = Date.today

  end

  def set_up(key, date)
    @coded_msg = ""
    key_hash = self.create_keys(key)
    offset_hash = self.create_offset(date)
    shift_array = key_hash.values
    @shift_array = shift_array
    offset_hash.values.each do |offset|
      @shift_array[0] += offset
      @shift_array.rotate!
    end
    @enigma_hash = { key: key, date: date }
  end

  def encrypt(message, key = random_key, date = @dd.strftime("%d%m%y"))
    set_up(key, date)
    message.downcase.chars.each do |char|
      if @letters.include?(char) == false then @coded_msg.concat(char) else
        rotate_counter = (@letters.index(char) + @shift_array[0])
        @coded_msg.concat(@letters.rotate(rotate_counter)[0])
        @shift_array.rotate!
      end
    end
    @enigma_hash[:encryption] = @coded_msg
    @enigma_hash
  end

  def decrypt(ciphertext, key = random_key, date = @dd.strftime("%d%m%y"))
    set_up(key, date)
    ciphertext.downcase.chars.each do |char|
      if @letters.include?(char) == false then @coded_msg.concat(char) else
        rotate_counter = (@letters.index(char) - @shift_array[0])
        @coded_msg.concat(@letters.rotate(rotate_counter)[0])
        @shift_array.rotate!
      end
    end
    @enigma_hash[:decryption] = @coded_msg
    @enigma_hash
  end

  def random_key
    rand.to_s[2..6]
  end
end
