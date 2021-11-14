require './modules/keys'

class Enigma
  include Keys
  def initialize
  end

  def encrypt(message, key, date)
    encrypt = Encrypt.new(message, key, date)
    encrypt.encrypts
  end

  def decrypt(message, key, date)
    decrypt = Decrypt.new(message, key, date)
    decrypt.decrypts
  end

end
