# odin-mastermind-game
The Odin Project's Mastermind Game project
Let's plan and outline first before writing code. How does this structure look: 

SecretCode Class
- purpose: 
-- responsible for creating a code to break and storing it
- instance variable
-- code (array)
- instance methods: 
-- initialize
-- generate_code: randomly creates the code to break

Game class
- purpose: controls game logic (active)
- instance variables:
-- code
-- gamestate
-- board
-- player
-- interface
- instance methods: 
-- initialize variables
1. game loop: run game logic
-- welcome
2. play 1 turn 
--- prompt the Interface class for guesser to enter a guess 
--- get the Board class to validate and provide feedback
--- get History class to track if code isn't correct
--- get Interface class to provide feedback and display board
2. check for game over conditions
--- while loop checking the Board's state for gameover?
--- get Interface to declare game, gets info from Board state if gameover
3. replay
--- repeat rounds until game over
-- ask to play another round 

GameState class
- purposes: tracks the state of the game
- instance variables
-- current_round
-- current_guess
-- game_over? conditions
-- winner?
- instance methods:
-- updates game_over?, winner? flag

Board class (tracks board state)
- purpose: owns the game rules & mechanics
-- validates guesses, provides feedback, tracks the guess history and the hints history
- instance variables: 
-- guesses_history (array)
-- hints_history (array)
-- current_guess
- instance methods:
-- initialize 
-- provides feedback on guess
-- validates the guess against the code in the Code class
-- tracks history of guesses, hints
-- checks for gameover conditions
-- correct guess?

Player class
- purpose: manages players 
- instance variables:
-- name
-- position as guesser or creator of code 
- instance methods: 
-- initialize variables

Interface class
- purpose: handles user IO (validate user inputs, prints messages to players, manages colors)
- library: colorize
- instance variables
- instance methods: 
-- gets guesser's inputs
-- validates inputs
-- prints message if invalid guess
-- display guess
-- display history of guess after every turn
-- display hints 

Configurations class
- purpose: stores the game settings 
- class variables:
--- code_length = 6
--- code_values = %w[red yellow orange green blue purple]
--- number_of_rounds = 12
- class methods:
-- declare variables above

ComputerPlayer class
- purpose: handles the computer player as the guesser
- instance variables: 
-- track guess 
- instance methods: 
-- requests a guess (reuse the SecretCode class)
-- guesses based trying each letter first
--- try the first letter of the valid code colors, e.g. RRRR
--- based on feedback, if feedback shows 0,0
      move to the next color e.g. YYYY
    else incorporate the feedback, 
      replace the number of colors in the next guess, 
      if feedback is 0, 1, e.g. BYYY
    the aim is to get to a feedback of 4
--- once you have feedback that adds up to 4, 
    use a bubble sort to move the colors into different
    positions until you get the right combination

-- avoid repeating guesses by observing the history
-- uses hints to track correct letters 

 main.rb
- instantiate new Game object
