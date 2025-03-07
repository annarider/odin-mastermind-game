# frozen_string_literal: true

# test_setup.rb tests the game setup.
# This includes all steps before playing a game,
# such as generating a code and coloring pegs. 
require_relative '../lib/configuration'
require_relative '../lib/secret_code'

p "CODE_LENGTH: #{Configuration::CODE_LENGTH}"
p "CODE_VALUES: #{Configuration::CODE_VALUES}"
p "NUMBER_OF_ROUNDS: #{Configuration::NUMBER_OF_ROUNDS}"

code = SecretCode.generate
p "code: #{code}"
code
