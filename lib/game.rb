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
  require_relative 'computer'
  require_relative 'game_state'
  attr_accessor :code, :state, :board, :interface, :human_player, :computer_player

  def initialize
    @interface = Interface.new
    create_players
    @code = create_code
    @board = Board.new(code)
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
    # name = interface.request_name # TODO: Remove
    name = 'Anna'
    # input_role = interface.request_role # TODO: Remove
    input_role = 'maker'
    role = input_role == 'maker' ? :codemaker : :codebreaker
    @human_player = Player.new(name, role)
    @computer_player = Computer.new
  end
  
  def create_code
    return interface.request_player_code if @human_player.role == :codemaker 

    SecretCode.generate
  end

  def play_turn
    if @human_player.role == :codemaker
      guess = @computer_player.guess(@board.hint_history.dup)
    else
      guess = interface.guess
    end
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
