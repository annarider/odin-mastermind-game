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
      ⭐️ Welcome to the Mastermind game.
      You will play against the computer.
      Computer will generate a secret code.
      You have #{Configuration::NUMBER_OF_ROUNDS} guesses to try to#{' '}
      crack the secret code. After each guess,
      if you haven't cracked the code yet, you will see#{' '}
      a history of your guesses and hints to help you.#{' '}
    WELCOME
  end

  def guess
    puts <<~REQUEST
      🔥 What's your guess?
      Guess a combination of #{Configuration::CODE_LENGTH} colors.#{' '}
      Valid colors are #{Configuration::CODE_VALUES.join('')}.#{' '}
      You will enter your guess in a format like this: #{SecretCode.generate.join('')}.#{' '}
      🆙 Type in your guess:
    REQUEST
    guess = request_guess
    guess_again until valid?(guess)
    guess
  end

  def request_name
    puts "Let's start. What's your name?"
    gets.chomp.strip
  end

  def show_board(board, state)
    puts 'History of your guesses:'
    puts show_guesses_with_hints(board)
    puts "Guess #{state.current_round} out of #{Configuration::NUMBER_OF_ROUNDS} guesses."
  end

  def announce_win
    puts 'Game over. You won and cracked the secret code!'
  end

  def announce_lose
    puts 'Game over. Sorry you ran out of guesses.'
  end

  private

  def request_guess
    gets.chomp.upcase.delete(' ').chars
  end

  def guess_again
    puts <<~REQUEST
      Invalid guess. Guess a combination of #{Configuration::CODE_LENGTH} colors.#{' '}
      Valid colors are #{Configuration::CODE_VALUES.join('')}.#{' '}
      An example guess is #{SecretCode.generate.join('')}. Guess again.#{' '}
    REQUEST
    request_guess
  end

  def valid?(guess)
    return false if guess.size != Configuration::CODE_LENGTH

    guess.all? { |color| Configuration::CODE_VALUES.include?(color) }
  end

  def show_guesses_with_hints(board)
    both_history = board.guess_history.zip(board.hint_history)
    both_history.map do |guess, hint|
      formatted_guess = "Guess: #{guess.join('')}"
      formatted_hint = "Hint: Exact matches #{hint[0]}, Correct colors #{hint[1]}"
      "#{formatted_guess} - #{formatted_hint}"
    end
  end
end
