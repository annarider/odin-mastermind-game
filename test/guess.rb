# frozen_string_literal: true

# test/guess.rb
require_relative '../lib/configuration'

# We'll monkey-patch the class instead
class SecretCode
  class << self
    # Store the original method
    alias original_generate generate if method_defined?(:generate)

    # Override with our fixed code method
    def generate
      # Fixed test code - you can change this to whatever you want
      %w[R G B Y]
    end
  end
end

puts 'DEBUG: Secret code will be: RGBY'
