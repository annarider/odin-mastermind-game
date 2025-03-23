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
  attr_accessor :code_length, :all_codes, :possible_codes, :last_guess
  
  def initialize
    @code_length = Configuration::CODE_LENGTH
    @possible_codes = Configuration::CODE_VALUES.dup
    @all_codes = @possible_codes.repeated_permutation(code_length).to_a
    @last_guess = first_guess
  end

  def guess(guess_history, hint_history)
    return last_guess if hint_history.empty?

    guess = analyze_feedback(hint_history)
    guess
  end

  private

  def first_guess
    (possible_codes[0] * code_length).chars
  end

  def analyze_feedback(hints)
    possible_codes.shift
    exact_match = hints[-1][0]
    return first_guess if exact_match == 0
      
    last_guess.pop(exact_match.to_i)
    elements_to_replace = code_length - exact_match
    elements_to_replace.times { last_guess.push(possible_codes[0]) }
  end

end
