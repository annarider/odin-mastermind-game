# frozen_string_literal: true

# Player represents a player in the game.
# It owns the player's information.
#
# @example Creating a new player
#   player = Player.new
class Player
  attr_accessor :name, :role

  def initialize(name, role)
    @name = name
    @role = role
  end

end
