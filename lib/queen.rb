# frozen_string_literal: true

require 'piece'

# Queen
class Queen < Piece
  def initialize(team)
    super()
    @team = team
    @mark = if @team == 'white'
              "\u2655"
            else
              "\u265B"
            end
  end
end
