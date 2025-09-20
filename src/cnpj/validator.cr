struct CNPJ
  # Provides CNPJ identifier validation method
  module Validator
    extend self

    private REGEX = %r{^[A-Z0-9]{12}\d{2}$|^[A-Z0-9]{2}\.[A-Z0-9]{3}\.[A-Z0-9]{3}/[A-Z0-9]{4}-\d{2}$}

    private ASCII_VALUE_OFFSET = 48

    private INVALID_CHARS = %r{[^A-Z0-9]}

    private BLOCK_LIST = [
      "11111111111111",
      "22222222222222",
      "33333333333333",
      "44444444444444",
      "55555555555555",
      "66666666666666",
      "77777777777777",
      "88888888888888",
      "99999999999999",
      "00000000000000",
    ]

    # Returns `true` if the given value is a valid CNPJ value, otherwise
    # returns false
    #
    # ```
    # CNPJ::Validator.valid?("11111111111111")     # => false
    # CNPJ::Validator.valid?("24485147000187")     # => true
    # CNPJ::Validator.valid?("24.485.147/0001-87") # => true
    # ```
    def valid?(value : String) : Bool
      return false unless valid_format?(value)
      return false if blocked?(value)

      numbers : Array(UInt8) = value.chars.select(&.alphanumeric?).map do |char|
        char.ord.to_u8 - ASCII_VALUE_OFFSET
      end

      valid_digit?(digit: numbers[12], numbers: numbers[0, 12]) &&
        valid_digit?(digit: numbers[13], numbers: numbers[0, 13])
    end

    private def valid_format?(value : String) : Bool
      value.matches? REGEX
    end

    private def blocked?(value : String) : Bool
      BLOCK_LIST.includes?(value.gsub(INVALID_CHARS, ""))
    end

    private def valid_digit?(digit : UInt8, numbers : Array(UInt8)) : Bool
      total = numbers.reverse.map_with_index { |number, index| ((index % 8) + 2) * number }.sum

      rest = total % 11

      if rest == 0 || rest == 1
        digit == 0
      else
        digit == (11 - rest)
      end
    end
  end
end
