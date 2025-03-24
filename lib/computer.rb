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
  attr_accessor :code_length, :all_codes, :possible_codes, 
    :last_guess, :correct_codes
  
  def initialize
    @code_length = Configuration::CODE_LENGTH
    @possible_codes = Configuration::CODE_VALUES.dup
    @all_codes = @possible_codes.repeated_permutation(code_length).to_a
    @last_guess = first_guess
    @correct_codes = nil
  end

  def guess(guess_history, hint_history)
    return last_guess if hint_history.empty?

    analyze_feedback(guess_history, hint_history)
  end

  private

  def first_guess
    (possible_codes[0] * code_length).chars
  end

  def analyze_feedback(guesses, hints)
    deleted_color = possible_codes.shift
    exact_match, color_match = hints[-1][0], hints[-1][1]
    if exact_match == 0 && color_match == 0
      remove_codes(deleted_color)
      @last_guess = first_guess
    else
      next_guess(guesses, exact_match, color_match) 
    end
    last_guess
  end
  
  def next_guess(guesses, exact_match, color_match)
    return sort(guesses, last_guess) if (exact_match + color_match) == 4
    
    if exact_match > 0
      elements_to_replace = code_length - exact_match
      last_guess.pop(elements_to_replace)
      elements_to_replace.times { last_guess.push(possible_codes[0]) }
    end
  end
  
  def random_pick
    all_codes.shuffle
  end

  def remove_codes(color)
    all_codes.delete_if { |code| code.include?(color) }
  end

  def sort(guesses, code)
    guess = code.shuffle until guesses.exclude?(guess)
    guess
  end
end
