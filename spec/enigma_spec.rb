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

  describe
end
