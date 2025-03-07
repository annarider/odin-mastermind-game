# frozen_string_literal: true

# SecretCode creates the code for the game.
#
# @example Creating a new code
#   code = SecretCode.new
class SecretCode
  require_relative 'configuration'
  attr_accessor :code

  def initialize
    @code = Configuration::CODE_VALUES.shuffle
  end
end
