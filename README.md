> [!WARNING]
> This repository is no longer maintained. Development will continue in the [gunbolt/cpf_cnpj](https://codeberg.org/gunbolt/cpf_cnpj)
> project, which provides the same features with expanded support for both CPF and CNPJ identifiers, along with database and serialization integrations.

# CNPJ

CNPJ identifier validation and formatting for Crystal already compatible
with the new alphanumeric CNPJ what will be available in 2026.

CNPJ (Cadastro Nacional de Pessoa Jurídica) is a Brazilian nationwide registry
of legal entities. It's an 14-character sequence in the format
XX.XXX.XXX/XXXX-00, where the last 2 digits are check digits, generated
through an arithmetic operation on the first 12 digits.

## Links
- [API Reference](https://crystaldoc.info/github/stephannv/cnpj)
- [CPF](https://github.com/stephannv/cpf)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cnpj:
     github: stephannv/cnpj
   ```

2. Run `shards install`

## Usage

[API Reference](https://crystaldoc.info/github/stephannv/cnpj)

```crystal
require "cnpj"

# With valid formatted value
cnpj = CNPJ.new("24.485.147/0001-87")
cnpj.value       # => "24.485.147/0001-87"
cnpj.formatted   # => "24.485.147/0001-87"
cnpj.unformatted # => "24485147000187"
cnpj.to_s        # => "24.485.147/0001-87"

# With valid unformatted value
cnpj = CNPJ.new("24485147000187")
cnpj.value       # => "24485147000187"
cnpj.formatted   # => "24.485.147/0001-87"
cnpj.unformatted # => "24485147000187"
cnpj.to_s        # => "24485147000187"
```

A `CNPJ` object is designed to never hold an invalid value, so you can assume
that a CNPJ object will always hold a valid value. If you try to initialize a
CNPJ object with an invalid value, it will raise an exception:

```crystal
CNPJ.new("11111111111111") # => raises `CNPJ::InvalidValueError`

CNPJ.new("11.111.111/1111-11") # => raises `CNPJ::InvalidValueError`
```

To safely initialize a CNPJ object, use the `.parse` method:
```crystal
# With invalid value
CNPJ.parse("11111111111111") # => nil

# With valid value
CNPJ.parse("24.485.147/0001-87") # => #<CNPJ:0x104fe0ae0 @value="24.485.147/0001-87">
```

You can use `CNPJ::Validator` module to validate a CNPJ identifier:
```crystal
CNPJ::Validator.valid?("11111111111111") # => false

CNPJ::Validator.valid?("24.485.147/0001-87") # => true
```

## Development

1. `shards install` to install dependencies
2. `crystal spec` to run tests

## Contributing

1. Fork it (<https://github.com/stephannv/cnpj/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [stephann](https://github.com/stephannv) - creator and maintainer
