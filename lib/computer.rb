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
  attr_accessor :all_codes, :colors, :count_guess
  
  def initialize
    @colors = Configuration::CODE_VALUES
    @all_codes = @colors.repeated_permutation(Configuration::CODE_LENGTH).to_a
  end

  def guess(guess_history, hint_history)
    p hint_history 
    p hint_history[-1].sum unless hint_history.empty?
    p all_codes.size
    p all_codes
    guess = colors[0] * Configuration::CODE_LENGTH
    guess.chars
  end

  private

end
