require './modules/keys'
require 'date'
class Enigma
  include Keys
  @@dd = Date.today
  def initialize
  end

  def encrypt(message, key = random_key, date = @@dd.strftime("%d%m%y"))
    encrypt = Encrypt.new(message, key, date)
    encrypt.encrypts
  end

  def decrypt(message, key = random_key, date = @@dd.strftime("%d%m%y"))
    decrypt = Decrypt.new(message, key, date)
    decrypt.decrypts
  end

  def random_key
    rand.to_s[2..6]
  end
end
