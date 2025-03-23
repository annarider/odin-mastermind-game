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
  attr_accessor :all_codes, :colors, :last_guess
  
  def initialize
    @colors = Configuration::CODE_VALUES
    @all_codes = @colors.repeated_permutation(Configuration::CODE_LENGTH).to_a
    @last_guess = (colors[0] + colors[0] + colors[1] + colors[1]).chars
  end

  def guess(guess_history, hint_history)
    return last_guess if hint_history.empty?

    guess = colors[0] * Configuration::CODE_LENGTH
    guess.chars
  end

  private

end
