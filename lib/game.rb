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

  def initialize
    @code = SecretCode.generate
    @board = Board.new(code)
    @interface = Interface.new
    @state = GameState.new
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
      interface.show_board
      break if state.check_game_over

    end
    announce_end
  end

  def play_turn
    guess = interface.guess
    until interface.valid?(guess)
      interface.guess_again
    end
    board.track_guess
    state.update_round(guess)
  end

  def announce_end
    if state.check_winner
      interface.announce_win
    elsif state.check_game_over
      interface.announce_lose
    end
  end

  def play_again?
    puts 'Play again? Enter y for yes (y): '
    gets.chomp.downcase == 'y'
  end

  def reset
    @board = Board.new
  end
end
