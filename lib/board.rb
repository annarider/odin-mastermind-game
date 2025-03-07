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

  private

  def history
    guess_history << current_guess
  end
end
