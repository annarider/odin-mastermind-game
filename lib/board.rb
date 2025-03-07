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
    exact_match = 0
    color_match = 0

    matches = []

    code.each_with_index do |color, index|
      if current_guess[index] == color
        matches[index] = color
        exact_match += 1
      else 
        matches[index] = nil
      end
    end

    p "exact_match: #{exact_match}"
    p "color_match: #{color_match}"
    p "matches: #{matches}"
  end
end
