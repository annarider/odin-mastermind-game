# frozen_string_literal: true

# Computer class controls the computer
# as the guesser player in the Mastermind game.
# It handles computer's guesses, analyzing
# hints to pick the next best guess.
#
# @example Creating a new computer player
#   computer = Computer.new
class Computer
  require_relative 'configuration'
  attr_accessor :remainder_code
  
  def initialize
    @remainder_code = Configuration::CODE_VALUES
  end

  def guess(guess_history, hint_history)
    guess = remainder_code[0] * Configuration::CODE_LENGTH
    guess.chars
  end
end
