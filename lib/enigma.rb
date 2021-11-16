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
    @shift_array = key_hash.values
    offset_hash.values.each do |offset|
      @shift_array[0] += offset
      @shift_array.rotate!
    end
    @enigma_hash = { key: key, date: date }
    # require "pry"; binding.pry
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

  def decrypt(message, key = random_key, date = @dd.strftime("%d%m%y"))
    set_up(key, date)
    message.downcase.chars.each do |char|
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

  def cracked_shift(message)
    @coded_msg = ""
    known_letters = [" ", "e", "n", "d"]
    @encrypted = message.downcase.chars
    el_index = @encrypted[-4..-1].map { |char| @letters.index(char)  }
    kl_index = known_letters.map{|char| @letters.index(char)}
    @shifts = kl_index.map do |number|
      number - el_index.rotate![-1]
    end
    @shifts.reverse!
  end

  def crack(message, date)
    cracked_shift(message)
    @encrypted.reverse.each do |char|
      if @letters.include?(char) == false then @coded_msg.concat(char) else
        rotate_counter = (@letters.index(char) + @shifts[0])
        @coded_msg.concat(@letters.rotate(rotate_counter)[0])
        @shifts.rotate!
      end
    end
    @coded_msg.reverse
  end
end
