# frozen_string_literal: true

# Board represents the Mastermind game board.
# It owns the game rules and mechanics.
# For example, it validates guesses, tracks
# the guess and hints histories, and
# checks for game over conditions.
#
# @example Creating a new board
#   board = Board.new
class Board
  require_relative 'configuration'
  attr_accessor :guess_history, :hint_history, :current_guess

  def initialize(guess)
    @guess_history = []
    @hint_history = []
    @current_guess = guess
  end

  def correct?(code)
    code == current_guess
  end

  def history
    guess_history << current_guess
  end

  def feedback(code)
    exact_matches = find_exact_match(code)
    color_matches = find_color_match(code, exact_matches)
    p code
    p current_guess
    p exact_matches
    p color_matches
    [exact_matches.size, color_matches.size]
  end

  def find_exact_match(code)
    matches = []
    code.each_with_index do |color, index|
    if current_guess[index] == color
        matches << current_guess[index]
      end
    end
    matches
  end

  def find_color_match(code, exact_matches)
    remainder_code = code - exact_matches
    remainder_guess = current_guess - exact_matches
    matches = []
    remainder_guess.each do |color|
      if remainder_code.include?(color)
        matches << color
        remainder_code.delete_at(remainder_code.index(color) || remainder_code.length)
      end
    end
    matches
  end

  def game_over?(code)
    correct?(code) || guess_history.size == Configuration::NUMBER_OF_ROUNDS
  end
end
