require './spec_helper'
require './lib/enigma'

RSpec.describe Enigma do
  let!(:enigma){Enigma.new}

  describe '#initialize' do
    it "exists" do
      expect(enigma).to be_a Enigma
    end
  end

  describe '#encrypt' do
    it "encrypts a given message and ignores punctuation" do
      expected = {
        encryption: "keder? ohulw!",
        key: "02715",
        date: "040895"
      }
      expect(enigma.encrypt("hello? world!", "02715", "040895")).to eq expected
    end

    it "encrypts a given message for the current day" do
      expected = {
        encryption: "pkfawfqdzry",
        key: "02715",
        date: "151121"
      }
      expect(enigma.encrypt("hello world", "02715")).to eq expected
    end

    it "encrypts a given message for the current day with a random key" do
      encrypted = enigma.encrypt("hello world")

      allow(encrypted[:date]).to receive("#{@dd}")
      allow(encrypted[:key]).to receive(:random_key)
    end

    it "encrypts a given message with a capital letter" do
      expected = {
        encryption: "pkfawfqdzry",
        key: "02715",
        date: "151121"
      }
      expect(enigma.encrypt("hellO World", "02715", "151121")).to eq expected
    end



  end

  describe '#decrypt' do
    it "decrypts a given message and ignores punctuation" do
      expected = {
        decryption: "hello world!",
        key: "02715",
        date: "040895"
      }
      expect(enigma.decrypt("keder ohulw!", "02715", "040895")).to eq expected
    end
  end

  describe '#crack' do
    it "cracks a given message with just a date" do
      encrypted = enigma.encrypt("this is the end", "46783", "151121")
      expected = {
        decryption: "this is the end",
        key: "46783",
        date: "151121"
      }
      # "r jvyatcr fccfe"
      expect(enigma.crack(encrypted[:encryption], "151121")).to eq expected
    end
  end

end
