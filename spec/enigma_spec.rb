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
      expect(@enigma.alphabet).to eq(["a"])
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