# frozen_string_literal: true

# Game represents the game controller.
# It controls the game logic and delegates
# actions to different classes.
#
# @example Creating a new game
#   game = Game.new
class Game
  require_relative 'board'
  require_relative 'configuration'
  require_relative 'game_state'
  require_relative 'interface'
  require_relative 'secret_code'
  attr_accessor :code, :state, :board, :interface

  def initialize(code, guess)
    @code = SecretCode.generate
    @state = GameState.new
    @board = Board.new
    @interface = Interface.new
  end
end
