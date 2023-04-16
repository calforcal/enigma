class Enigma
  attr_reader :alphabet

  def initialize
    @alphabet = ("a".."z").to_a << " "
  end

  def encrypt(message, key, date)
    split_message = message.split("")
    encrypted_string = encrypt_message(split_message, key, date)

    {
      encryption: "#{encrypted_string}",
      key: "#{key}",
      date: "#{date}"
    }
  end

  def key_generator(key)
    {
      "#{@alphabet[0].upcase}": key[0, 2].to_i,
      "#{@alphabet[1].upcase}": key[1, 2].to_i,
      "#{@alphabet[2].upcase}": key[2, 2].to_i,
      "#{@alphabet[3].upcase}": key[3, 2].to_i
    }
  end

  def offset_generator(date)
    date_squared = date.to_i ** 2
    last_four = date_squared.to_s[-4, 4]
    {
      "#{@alphabet[0].upcase}": last_four[0].to_i,
      "#{@alphabet[1].upcase}": last_four[1].to_i,
      "#{@alphabet[2].upcase}": last_four[2].to_i,
      "#{@alphabet[3].upcase}": last_four[3].to_i
    }
  end

  def final_shift(key, date)
    finals = key_generator(key).merge!(offset_generator(date)) { |key, key_value, offset_value| key_value + offset_value }
  end

  def encrypt_message(array, key, date)
    shift = final_shift(key, date)
    count = 0
    array.map do |char|
      if !@alphabet.include?(char)
        char
      elsif count == 0
        count += 1
        shift_a(char, shift[:"A"])
      elsif count == 1
        count += 1
        shift_b(char, shift[:"B"])
      elsif count == 2
        count += 1
        shift_c(char, shift[:"C"])
      elsif count == 3
        count += 1
        shift_d(char, shift[:"D"])
      elsif count % 4 == 0
        count += 1
        shift_a(char, shift[:"A"])
      elsif count % 4 == 1
        count += 1
        shift_b(char, shift[:"B"])
      elsif count % 4 == 2
        count += 1
        shift_c(char, shift[:"C"])
      elsif count % 4 == 3
        count += 1
        shift_d(char, shift[:"D"])
      end
    end.join("")
  end

  def get_value(num)
    if num > 27
      num % 27
    else
      num
    end
  end

  def under_27(num1, num2)
    if num1 + num2 > 27
      num1 + num2 - 27
    else
      num1 + num2
    end
  end

  def shift_a(char, shift_key)
    index = @alphabet.index(char)
    shift_value = under_27(index, get_value(shift_key))
    @alphabet[shift_value]
  end

  def shift_b(char, shift_key)
    index = @alphabet.index(char)
    shift_value = under_27(index, get_value(shift_key))
    @alphabet[shift_value]
  end

  def shift_c(char, shift_key)
    index = @alphabet.index(char)
    shift_value = under_27(index, get_value(shift_key))
    @alphabet[shift_value]
  end

  def shift_d(char, shift_key)
    index = @alphabet.index(char)
    shift_value = under_27(index, get_value(shift_key))
    @alphabet[shift_value]
  end
end