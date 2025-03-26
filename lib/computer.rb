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
                :last_guess

  def initialize
    @code_length = Configuration::CODE_LENGTH
    @possible_codes = Configuration::CODE_VALUES.dup
    @all_codes = @possible_codes.repeated_permutation(code_length).to_a
    @last_guess = first_guess
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
    exact_match = hints[-1][0]
    color_match = hints[-1][1]
    if exact_match.zero? && color_match.zero?
      delete_all_instances(deleted_color)
      @last_guess = first_guess
    else
      @last_guess = next_guess(deleted_color, exact_match, color_match)
    end
    last_guess
  end

  def next_guess(color, exact_match, color_match)
    feedback_sum = exact_match + color_match
    return sort if feedback_sum == 4

    replace_code_elements(color, feedback_sum)
  end

  def sort
    all_codes.delete(last_guess)
    correct_count = last_guess.each_with_object(Hash.new(0)) do |color, count|
      count[color] += 1
    end
    remove_codes(correct_count)
    random_pick
  end

  def random_pick
    all_codes.sample
  end

  def remove_codes(correct_count)
    @all_codes = @all_codes.select do |code|
      code_counts = Hash.new(0)
      code.each { |color| code_counts[color] += 1 }
      code_counts == correct_count
    end
    @all_codes
  end

  def delete_all_instances(color)
    @all_codes.delete_if { |code| code.include?(color) }
  end

  def replace_code_elements(feedback_sum)
    new_guess = last_guess.dup
    (code_length - feedback_sum).times do |i|
      p i
      new_guess[i] = possible_codes[0]
    end
    puts "Debug - new_guess length: #{new_guess.length}, content: #{new_guess.join}"
    p new_guess
    new_guess
  end
end
