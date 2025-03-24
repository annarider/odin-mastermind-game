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
    :last_guess, :correct_codes, :position
  
  def initialize
    @code_length = Configuration::CODE_LENGTH
    @possible_codes = Configuration::CODE_VALUES.dup
    @all_codes = @possible_codes.repeated_permutation(code_length).to_a
    @last_guess = first_guess
    @correct_codes = []
    @position = 0
  end

  def guess(hint_history)
    return last_guess if hint_history.empty?

    analyze_feedback(hint_history)
  end

  private

  def first_guess
    (possible_codes[0] * code_length).chars
  end

  def analyze_feedback(hints)
    deleted_color = possible_codes.shift
    exact_match, color_match = hints[-1][0], hints[-1][1]
    if exact_match == 0 && color_match == 0
      remove_codes(deleted_color)
      @last_guess = first_guess
    else
      @last_guess = next_guess(deleted_color, exact_match, color_match) 
    end
    last_guess
  end
  
  def next_guess(color, exact_match, color_match)
    feedback_sum = exact_match + color_match
    @correct_codes.push([color, feedback_sum])
    return sort if feedback_sum == 4
    
    replace_code_elements(color, feedback_sum)
  end
    
  def random_pick
    all_codes.shuffle
  end
  
  def remove_codes(color)
    all_codes.delete_if { |code| code.include?(color) }
  end
  
  def sort
    last_guess[position], last_guess[position + 1] = last_guess[position + 1], last_guess[position]
    @position += 1
    last_guess
  end
  
  def replace_code_elements(color, feedback_sum)
    remove_codes(color)

    new_guess = last_guess.dup
    new_guess.each_with_index do |_c, index|
      new_guess[index] = possible_codes[0] if index < (code_length - feedback_sum)
      index += 1
    end
    new_guess
  end
end
