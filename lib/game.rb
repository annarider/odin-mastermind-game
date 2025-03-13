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
  require_relative 'board'
  require_relative 'configuration'
  require_relative 'game_state'
  require_relative 'interface'
  require_relative 'secret_code'
  attr_accessor :code, :state, :board, :interface, :guesser

  def initialize(code, guess)
    @code = SecretCode.generate
    @state = GameState.new
    @board = Board.new
    @interface = Interface.new
  end

  def play
    play_round
    while play_again?
      reset
      play_round
    end
  end

  private

  def create_players
    guesser_name = interface.get_name
    @guesser = Player.new(guesser_name)
  end

  def play_round
    loop do
      play_turn
      board.show_board
      break if state.game_over?

    end
    announce_end
  end

  def play_turn
    position = current_player.choose
    until board.valid_move?(position)
      current_player.choose_again
      position = current_player.choose
    end
    board.set_symbol(position, current_player.symbol)
  end

  def announce_end
    if state.winner?
      interface.announce_win
    elsif state.game_over?
      interface.announce_lose
    end
  end

  def play_again?
    puts 'Play again? Enter y for yes (y): '
    gets.chomp.downcase == 'y'
  end

  def reset
    @board = GameBoard.new
    @current_player = play_order
    puts "Let's play again. It's #{current_player.name}'s turn."
  end
end
