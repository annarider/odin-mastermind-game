# frozen_string_literal: true

# SecretCode creates the code for the game.
#
# @example Creating a new code
#   code = SecretCode.new
class SecretCode
  require_relative 'configuration'

  def self.generate
    Configuration::CODE_LENGTH.times.map { Configuration::CODE_VALUES.sample }
  end
end
