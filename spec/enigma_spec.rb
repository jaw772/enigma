require './lib/enigma'
require './lib/encrypt'
require './lib/decrypt'
require './spec_helper'
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
        encryption: "keder ohulw",
        key: "02715",
        date: "040895"
      }
      expect(enigma.encrypt("hello world", "02715", "040895")).to eq expected
    end
  end
end
