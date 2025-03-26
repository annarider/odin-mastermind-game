# frozen_string_literal: true

# test/debug_game.rb
# First load the original code
require_relative '../lib/secret_code'
# Then override with our test version
require_relative 'guess'
# Finally load the main program
require_relative '../main'
