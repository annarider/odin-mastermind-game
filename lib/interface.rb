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
  require_relative 'secret_code'

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

  def guess
    puts <<~REQUEST
    What's your guess?
    Guess a combination of #{Configuration::CODE_LENGTH} colors. 
    Valid colors are #{Configuration::CODE_VALUES.join('')}. 
    You will enter your guess in a format like this: #{SecretCode.generate}. 
    REQUEST
    get_guess
  end
  
  def guess_again
    puts <<~REQUEST
    Invalid guess. Guess a combination of #{Configuration::CODE_LENGTH} colors. 
    Valid colors are #{Configuration::CODE_VALUES.join('')}. 
    An example guess is #{SecretCode.generate.join('')}. Guess again. 
    REQUEST
    get_guess
  end

  def valid?(guess)
    return false if guess.size != Configuration::CODE_LENGTH
    guess.all? { |color| Configuration::CODE_VALUES.include?(color)}
  end
  
  def show_board(board)
    puts show_history(board), show_hint(board), show_round(board)
  end
  
  def get_guess
    gets.chomp.upcase.delete(' ').chars
  end
  
  private
  
  def show_history(board)
    board.history.each { |guess| guess.join('')}
  end
  
  def show_hint(board)
    board.hint.join(', ')
  end

  def show_round(board)
    current_round = board.guess_history.size #TODO state is GameState's job
    "Guess #{current_round} out of #{Configuration::NUMBER_OF_ROUNDS} guesses."
  end
end
