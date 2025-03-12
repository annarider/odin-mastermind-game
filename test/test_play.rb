# frozen_string_literal: true

# test_play.rb tests the game logic.
# It begins from starting a new game.
# It doesn't manage game setup.
require_relative 'test_setup'
require_relative '../lib/board'

module TestPlay
  @@code = nil
  @@board = nil
  @@guess = nil

  def self.setup
    @@code = TestSetup.generate_code
    @@guess = TestSetup.generate_code
    @@board = Board.new(@@code, @@guess)
    p "code: #{@@code}, guess: #{@@guess}"
  end

  def self.test_board_setup
    p "board: #{@@board}"
    p "check code guess: #{@@board.win?(@@code)}"
    p "check random guess: #{@@board.win?(@@guess)}"
  end
  
  def self.test_guess_feedback
    p "feedback: #{@@board.feedback(@@code)}"
    p "feedback: #{@@board.feedback(@@guess)}"
  end
  
  def self.test_gameover
    p "gameover with code? #{@@board.game_over?}, #{@@code}"
    p "gameover with guess? #{@@board.game_over?}, #{@@guess}}"
  end
  
  def self.test_board_history
    p "history: #{@@board.history}"
  end
end

if __FILE__ == $PROGRAM_NAME
  TestPlay.setup
  # TestPlay.test_board_setup
  # TestPlay.test_guess_feedback
  TestPlay.test_gameover
  TestPlay.test_board_history
end
