# frozen_string_literal: true

require 'piece'

# Knight
class Knight < Piece
  def initialize(team)
    super()
    @team = team
    @mark = if @team == 'white'
              "\u2658"
            else
              "\u265E"
            end
  end
end
