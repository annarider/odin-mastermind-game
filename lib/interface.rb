# frozen_string_literal: true

# Interface acts as the Mastermind game's
# physical board.
# It handles input and output to and from 
# players and performs data validation.
#
# @example Creating a new interface
#   interface = Interface.new
class Interface
  require_relative 'configuration'

  def welcome
    puts <<~WELCOME 
      Welcome to the Mastermind game.
      You will play against the computer.
      Computer will generate a secret code.
      You have #{Configuration::NUMBER_OF_ROUNDS} guesses
      to try to crack the secret code. After each guess,
      if you haven't cracked the code yet, you will see 
      a history of your guesses and hints to help you. 
    WELCOME
  end
  
end
