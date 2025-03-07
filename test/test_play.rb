# frozen_string_literal: true

# test_play.rb tests the game logic.
# It begins from starting a new game.
# It doesn't manage game setup.
require_relative 'test_setup'
require_relative '../lib/board'

module TestPlay
  def self.create_game
    code = TestSetup.generate_code
    board = Board.new(code)
    p board
  end
end

if __FILE__ == $PROGRAM_NAME
  TestPlay.create_game
end
