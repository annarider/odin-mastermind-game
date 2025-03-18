# frozen_string_literal: true

# GameState owns the state of the game.
# It tracks the current round, current
# guess, game_over, winner, conditions, etc.
#
# @example Creating a new state
#   state = GameState.new
class GameState
  require_relative 'configuration'
  attr_accessor :current_round, :current_guess, :game_over, :winner

  def initialize(guess = nil)
    @current_round = 0
    @current_guess = guess
    @game_over = false
    @winner = false
  end

  def check_game_over(board)
    @game_over = board.game_over?
  end

  def check_winner(board)
    @winner = board.win?
  end

  def update_round(guess)
    @current_guess = guess
    @current_round += 1
  end
end
