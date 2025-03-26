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
  attr_accessor :code, :guess_history, :hint_history, :current_guess

  def initialize(code = nil, guess = nil)
    @guess_history = []
    @hint_history = []
    @code = code
    @current_guess = guess
  end

  def game_over?
    win? || guess_history.size == Configuration::NUMBER_OF_ROUNDS
  end

  def win?
    code == current_guess
  end

  def track_guess(guess)
    @current_guess = guess
    history
    hint
  end

  private

  def history
    guess_history << current_guess
  end

  def hint
    hint_history << feedback
  end

  def feedback
    exact_matches = find_exact_match
    color_matches = find_color_match(exact_matches)
    [exact_matches.size, color_matches.size]
  end

  def find_exact_match
    matches = []
    code.each_with_index do |color, index|
      matches << current_guess[index] if current_guess[index] == color
    end
    matches
  end

  def find_color_match(exact_matches)
    remainder_code, remainder_guess = remove_exact_matches(exact_matches)
    matches = []
    remainder_guess.each do |color|
      if remainder_code.include?(color)
        matches << color
        remainder_code.delete_at(remainder_code.index(color) || remainder_code.length)
      end
    end
    matches
  end

  def remove_exact_matches(exact_matches)
    remaining_code = code.dup
    remaining_guess = current_guess.dup

    exact_matches.each do |color|
      code_index = remaining_code.index(color)
      remaining_code.delete_at(code_index) if code_index
      guess_index = remaining_guess.index(color)
      remaining_guess.delete_at(guess_index) if guess_index
    end
    [remaining_code, remaining_guess]
  end
end
