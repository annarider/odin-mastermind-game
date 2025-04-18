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
    request_code
  end

  def request_name
    puts "Let's start. What's your name?"
    gets.chomp.strip
  end

  def request_role
    puts 'Do you want to be code maker or breaker?'
    puts 'Type in maker or breaker:'
    role = gets.chomp.downcase.strip
    confirm_role(role)
  end

  def request_player_code
    puts <<~REQUEST
      🔠 You're the code maker.
      Please give me a code for the computer to break.
    REQUEST
    valid_code_examples
    request_code
  end

  def show_board(board, state)
    puts 'History of guesses:'
    puts show_guesses_with_hints(board)
    puts "Guess #{state.current_round} out of #{Configuration::NUMBER_OF_ROUNDS} guesses."
  end

  def announce_win
    puts "Game over. It's a win! Codecracker cracked the secret code!"
  end

  def announce_lose
    puts "Game over. Sorry we're ran out of guesses."
  end

  private

  def confirm_role(role)
    if %w[maker breaker].include?(role)
      puts "Great. You will be the code #{role}."
    else
      puts "Sorry, I couldn't detect your chosen role. I'll randomly assign your role."
      role = %w[maker breaker].sample
      puts "You will be the code #{role} for this game."
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
      Create a code for the computer to break.#{' '}
    MESSAGE
    valid_code_examples
  end

  def request_code
    code = gets.chomp.upcase.delete(' ').chars
    code = code_again until valid?(code)
    code
  end

  def code_again
    puts '❌ Invalid code. Please provide your code again.'
    request_code
  end

  def valid_code_examples
    puts <<~REQUEST
      Valid colors are #{Configuration::CODE_VALUES.join('')}.
      Guess a combination of #{Configuration::CODE_LENGTH} colors.
      An example code is #{SecretCode.generate.join('')}.
    REQUEST
  end

  def valid?(code)
    return false if code.size != Configuration::CODE_LENGTH

    code.all? { |color| Configuration::CODE_VALUES.include?(color) }
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
