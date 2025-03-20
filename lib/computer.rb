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
  
  def initialize
  end

  def first_guess
    p Configuration::CODE_VALUES * Configuration::CODE_LENGTH
  end
end
