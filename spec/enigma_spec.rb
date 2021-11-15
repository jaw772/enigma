require './spec_helper'
require './lib/enigma'
require './lib/encrypt'
require './lib/decrypt'


RSpec.describe Enigma do
  let!(:enigma){Enigma.new}

  describe '#initialize' do
    it "exists" do
      expect(enigma).to be_a Enigma
    end
  end

  describe '#encrypt' do
    it "encrypts a given message" do
      expected = {
        encryption: "keder ohulw!",
        key: "02715",
        date: "040895"
      }
      expect(enigma.encrypt("hello world!", "02715", "040895")).to eq expected
    end

    it "encrypts a given message for the current day" do
      expected = {
        encryption: "pkfawfqdzry",
        key: "02715",
        date: "131121"
      }
      expect(enigma.encrypt("hello world", "02715")).to eq expected
    end

    it "encrypts a given message for the current day with a random key" do
      encrypted = enigma.encrypt("hello world")

      allow(encrypted[:key]).to receive(:random_key)
    end

    it "encrypts a given message for the current day with a capital letter" do
      expected = {
        encryption: "pkfawfqdzry",
        key: "02715",
        date: "131121"
      }
      expect(enigma.encrypt("hellO World", "02715")).to eq expected
    end



  end

  describe '#decrypt' do
    it "decrypts a given message" do
      expected = {
        decryption: "hello world",
        key: "02715",
        date: "040895"
      }
      expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq expected
    end
    it "decrypts a given message for the current day" do
      expected = {
        decryption: "hello world",
        key: "02715",
        date: "131121"
      }
      encrypted = enigma.encrypt("hello world", "02715")
      expect(enigma.decrypt(encrypted[:encryption], "02715")).to eq expected
    end
  end
end
