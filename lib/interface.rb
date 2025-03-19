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
    WELCOME
  end

  def guess
    valid_code_examples
    puts <<~REQUEST
      🔥 What's your guess?
      🆙 Type in your guess:
    REQUEST
    guess = request_code
    guess = guess_again until valid?(guess)
    guess
  end

  def request_name
    puts "Let's start. What's your name?"
    gets.chomp.strip
  end

  def request_role
    puts 'Do you want to be code maker or breaker?'
    puts 'Type in maker or breaker:'
    role = gets.chomp.upcase.strip
    confirm_role
  end

  def request_player_code
    puts <<~REQUEST
      🔠 You're the code maker.#{' '}
      Please give me a code for the computer to break.
    REQUEST
    valid_code_examples
    request_code
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

  def confirm_role(role)
    if role == 'MAKER' || role == 'BREAKER'
      puts "Great. You will be #{role}"
    else
      puts "Couldn't detect your chosen role."
      role = %w[MAKER BREAKER].sample
      puts "You will be #{role} for this game."
    end
    role  
  end

  def code_breaker_message
    puts <<~MESSAGE
      Computer will generate a secret code.
      You have #{Configuration::NUMBER_OF_ROUNDS} guesses to try to
      crack the secret code. After each guess,
      if you haven't cracked the code yet, you will see
      a history of your guesses and hints to help you.
    MESSAGE
  end

  def code_maker_message
    puts <<~MESSAGE
      Create a code for the computer to break. 
    MESSAGE
    valid_code_examples
  end

  def request_code
    gets.chomp.upcase.delete(' ').chars
  end

  def guess_again
    puts '❌ Invalid guess. Guess again.'
    request_code
  end

  def valid_code_examples
    puts <<~REQUEST
      Valid colors are #{Configuration::CODE_VALUES.join('')}.
      Guess a combination of #{Configuration::CODE_LENGTH} colors.
      An example code is #{SecretCode.generate.join('')}.
    REQUEST
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
