# frozen_string_literal: true

# Player objects move pieces on the board
class Player
  attr_accessor :turn, :team

  # make sure to enter 
  def initialize(team)
    @team = team
  end
end
