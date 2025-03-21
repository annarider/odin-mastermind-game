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

  def guess(board)
    remainder_code.each do |color|
      color * Configuration::CODE_LENGTH
    end
    p board
  end
end
