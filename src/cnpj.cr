require "./cnpj/validator"

# Represents a CNPJ (Cadastro Nacional de Pessoas Jurídica) identifier.
#
# A `CNPJ` object is designed to never hold an invalid value, so you can assume
# that a CNPJ object will always hold a valid value.
# ```
# cnpj = CNPJ.new("24.485.147/0001-87")
# cnpj.value       # => "24.485.147/0001-87"
# cnpj.formatted   # => "24.485.147/0001-87"
# cnpj.unformatted # => ""24485147000187""
#
# CNPJ.new("11111111111111") # => raises `ArgumentError`
#
# CNPJ.parse("11111111111111")     # => nil
# CNPJ.parse("24.485.147/0001-87") # => #<CNPJ:0x104fe0ae0 @value="24.485.147/0001-87">
# ```
struct CNPJ
  VERSION = "1.0.0"

  class InvalidValueError < ArgumentError
  end

  getter value : String

  # Creates a `CNPJ` from a `String`.
  #
  # It accepts formatted and stripped strings
  #
  # If the String isn't a valid CNPJ, an `CNPJ::InvalidValueError` exception will be
  # raised. See `.parse` if you want a safe way to initialize a CNPJ.
  def self.new(value : String) : CNPJ
    new(value, validate: true)
  end

  # Returns a `CNPJ` if the given String is a valid CNPJ identifier, otherwise
  # returns `nil`.
  def self.parse(value : String) : CNPJ?
    return unless CNPJ::Validator.valid?(value)

    new(value, validate: false)
  end

  private def initialize(@value : String, validate : Bool)
    return unless validate

    unless CNPJ::Validator.valid?(value)
      raise CNPJ::InvalidValueError.new("Invalid CNPJ value")
    end
  end

  # Returns the formatted CNPJ identifier
  #
  # ```
  # cpf = CNPJ.new("24485147000187")
  # cpf.formatted # => "24.485.147/0001-87"
  # ```
  def formatted : String
    value.gsub(/^([A-Z0-9]{2})([A-Z0-9]{3})([A-Z0-9]{3})([A-Z0-9]{4})(\d{2})$/, "\\1.\\2.\\3/\\4-\\5")
    # value.gsub(/^(\d{3})(\d{3})(\d{3})(\d{2})$/, "\\1.\\2.\\3-\\4")
  end

  # Returns the unformatted CNPJ identifier
  #
  # ```
  # cpf = CNPJ.new("24.485.147/0001-87")
  # cpf.unformatted # => "24485147000187"
  # ```
  def unformatted : String
    value.gsub(/[^A-Z0-9]/, "")
  end
end
