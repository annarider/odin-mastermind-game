# odin-mastermind-game
The Odin Project's Mastermind Game project

Let's plan and outline first before writing code. How does this structure look: 

SecretCode Class
- purpose: 
-- responsible for creating a code to break
- constants: CODE_LENGTH = 6, CODE_VALUES = %w[red yellow orange green blue purple]
- instance variable
-- code (array)
- instance methods: 
-- initialize
-- generate_code: randomly creates the code to break

Game class
- purpose: manages game logic, play again logic
- constants: NUMBER_OF_ROUNDS = 12
- instance variables:
-- game_over?
- instance methods: 
-- initialize variables
-- game loop
1. create objects
--- instantiate new Board object
--- instantiate 2 new Player objects (guessor and creator)
--- get Code class to create a new secret code
--- get History class to create guesses and hints history
2. run game logic
--- prompt the Interface class for guesser to enter a guess 
--- get the Board class to validate and provide feedback
--- get History class to track if code isn't correct
--- get Interface class to provide feedback and display board
3. check for game over conditions
--- while loop checking the Board's state for gameover?
--- get Interface to declare game over if the guesses didn't get the code and the rounds are finished or if the guesses correctly guessed
4. replay
--- repeat rounds until game over
-- ask to play another round 

Board class (tracks board state)
- purpose: validates guesses, provides feedback
- instance methods:
-- initialize variables
-- validates the guess against the code in the Code class
-- checks for gameover conditions

Player class
- instance variables:
-- name
-- position as guesser or creator of code 
- instance methods: 
-- initialize variables

History class
- purposes: tracks the guess history, tracks the hints history
- instance variables: 
-- guesses (hash)
-- hints (hash)
- instance methods:
-- initialize 
-- tracks history of guesses

Interface class
- library: colorize
- purpose: validate user inputs, prints messages to players, manages colors
- instance variables
- instance methods: 
-- gets guesser's inputs
-- validates inputs
-- prints message if invalid guess
-- display guess
-- display history of guess after every turn
-- display hints 

 main.rb
- instantiate new Game object
