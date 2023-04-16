require "./spec/spec_helper"

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
  end
  describe "#initialize" do
    it "initializes" do
      expect(@enigma.class).to eq(Enigma)
    end

    it "initializes with an alphabet" do
      expect(@enigma.alphabet).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
    end
  end

  describe "#key_generator" do
    it "can generate a key hash with the key given" do
      expect(@enigma.key_generator("02715")).to eq(
      {
        "A": 2,
        "B": 27,
        "C": 71,
        "D": 15
      })
    end
  end

  describe "#offset_generator" do
    it "can generate a offset hash with the date given" do
      expect(@enigma.offset_generator("040895")).to eq(
        {
          "A": 1,
          "B": 0,
          "C": 2,
          "D": 5
        })
    end
  end

  describe "#final_shift" do
    it "can return a combined hash of key && offset" do
      expect(@enigma.final_shift("02715", "040895")).to eq(
        {
          "A": 3,
          "B": 27,
          "C": 73,
          "D": 20
        })
    end
  end

  describe "#encrypt" do
    it "can encrypt a message with a key and date" do
      expect(@enigma.encrypt("hello world", "02715", "040895")).to eq(
        {
          encryption: "keder ohulw",
          key: "02715",
          date: "040895"
        })
    end
  end
end