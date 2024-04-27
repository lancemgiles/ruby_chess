# frozen_string_literal: true

# Player objects move pieces on the board
class Player
  attr_accessor :turn, :team

  def initialize(team)
    @team = team
  end

  def move(start, target)
  end
end
