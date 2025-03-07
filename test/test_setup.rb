require_relative '../lib/configuration'
require_relative '../lib/secret_code'

p Configuration::CODE_LENGTH
p Configuration::CODE_VALUES
p Configuration::NUMBER_OF_ROUNDS

code = SecretCode.new
p code
