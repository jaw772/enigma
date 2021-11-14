require './modules/keys'

class Enigma
  include Keys
  def initialize
  end

  def encrypt(message, key, date)
    encrypt = Encrypt.new(message, key, date)
    encrypt.encrypts
  end
end
