# frozen_string_literal: true

# Game represents the game controller.
# It controls the game logic and delegates
# actions to different classes.
# It is active whereas its counterpart,
# the GameState class, is passive.
#
# @example Creating a new game
#   game = Game.new
class Game
  require_relative 'configuration'
  require_relative 'secret_code'
  require_relative 'board'
  require_relative 'interface'
  require_relative 'player'
  require_relative 'game_state'
  attr_accessor :code, :state, :board, :interface, :human_player

  def initialize
    @code = SecretCode.generate
    @board = Board.new(code)
    @interface = Interface.new
    create_players
    @state = GameState.new
  end

  def play
    interface.welcome
    loop do
      play_turn
      interface.show_board(@board, @state)
      break if state.check_game_over(@board)
    end
    announce_end
  end

  private

  def create_players
    name = interface.request_name
    input_role = interface.request_role
    role = input_role == 'MAKER' ? :codemaker : :codebreaker
    @human_player = Player.new(name, role)
  end

  def play_turn
    guess = interface.guess
    board.track_guess(guess)
    state.update_round(guess)
  end

  def announce_end
    if state.check_winner(@board)
      interface.announce_win
    elsif state.check_game_over(@board)
      interface.announce_lose
    end
  end
end
