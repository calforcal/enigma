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

    it "initializes with a random 5 character number" do
      expect(@enigma.key.length).to eq(5)
    end
  end

  describe "#check_rand" do
    it "checks if a random key is within the specified range" do
      expect(@enigma.check_rand(@enigma.random_num)).to be(true)
      expect(@enigma.check_rand(@enigma.random_num)).to be(true)
      expect(@enigma.check_rand(@enigma.random_num)).to be(true)
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

  describe "#get_value" do
    it "can get the remainder of a number greater then 27" do
      expect(@enigma.get_value(5)).to eq(5)
      expect(@enigma.get_value(32)).to eq(5)
      expect(@enigma.get_value(1250)).to eq(8)
    end
  end

  describe "#get_shift" do
    it "can return the needed shift value for a key and offset" do
      expect(@enigma.get_shift(2, 3)).to eq(5)
      expect(@enigma.get_shift(27, 5)).to eq(5)
      expect(@enigma.get_shift(25, 9)).to eq(7)
    end
  end

  describe "#encrypt_message" do
    it "can encrypt the message and return it as a string" do
      expect(@enigma.encrypt_message("hello world", "02715", "040895")).to eq("keder ohulw")
      expect(@enigma.encrypt_message("Michael Callahan", "02715", "040895")).to eq("pivadedtfadedhtg")
    end

    it "can handle all uppercase" do
      lower = @enigma.encrypt_message("BEWARE OF ME", "12345", "041623")
      expect(lower[0]).to eq("r")
      expect(lower[5]).to eq("b")
      expect(lower[-1]).to eq("e")
    end

    it "can return strings with special characters" do
      special = @enigma.encrypt_message("In! The. Dark - of -- the night: beware", "58903", "041623")
      expect(special[2]).to eq("!")
      expect(special[7]).to eq(".")
    end
  end

  describe "#shift_a && b && c && d" do
    it "can shift a given value based on the key given" do
      expect(@enigma.shift("a", 2)).to eq("c")
      expect(@enigma.shift("b", 3)).to eq("e")
      expect(@enigma.shift("c", 4)).to eq("g")
      expect(@enigma.shift("d", 5)).to eq("i")
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

    it "can encrypt a message with todays date" do
      expect(@enigma.encrypt("hello world", "02715")).to eq(
        {
          encryption: "rndiyiolauw",
          key: "02715",
          date: "190423"
        })
    end
  end

  describe "#get_unshift" do
    it "can return the unshift value for a key and offset" do
      expect(@enigma.get_unshift(27, 9)).to eq(18)
      expect(@enigma.get_unshift(1, 8)).to eq(20)
    end
  end

  describe "#unshift_a && b && c && d" do
    it "can unshift a given value based on the key given" do
      expect(@enigma.unshift("c", 2)).to eq("a")
      expect(@enigma.unshift("e", 3)).to eq("b")
      expect(@enigma.unshift("g", 4)).to eq("c")
      expect(@enigma.unshift("i", 5)).to eq("d")
    end
  end

  describe "#decrypt_message" do
    it "can decrypt a message and return it as a string" do
      expect(@enigma.decrypt_message("keder ohulw", "02715", "040895")).to eq("hello world")
    end

    it "can handle special characters" do
      expect(@enigma.decrypt_message("!!keder. ohulw--?", "02715", "040895")).to eq("!!hello. world--?")
    end

    it "can decrypt with todays date" do
      expect(@enigma.decrypt_message("wrvekndxmjdikqtk", "02715")).to eq("michael callahan")
    end
  end

  describe "#decrypt" do
    it "can decrypt a message when given the key and date" do
      expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq(
        {
          encryption: "hello world",
          key: "02715",
          date: "040895"
        })
    end

    it "can decrypt a message with todays date" do
      expect(@enigma.decrypt("rndiyiolauw", "02715")).to eq(
        {
          encryption: "hello world",
          key: "02715",
          date: "190423"
        })
    end
  end
end