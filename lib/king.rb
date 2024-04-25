# frozen_string_literal: true

require 'piece'

# King
class King < Piece
  def initialize(team)
    super()
    @team = team
    @mark = if @team == 'white'
              "\u2654"
            else
              "\u265A"
            end
  end
end
