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
    [exact_matches, color_matches]
  end

  def find_exact_match(code)
    matches = []
    code.each_with_index do |color, index|
    if current_guess[index] == color
        matches[index] = color
      else 
        matches[index] = nil
      end
    end
    matches
  end

  def find_color_match(code, exact_matches)
    nil
  end
end
