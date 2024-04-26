# frozen_string_literal: true

require_relative 'piece'

# Bishop
class Bishop < Piece
  def initialize(team)
    super()
    @team = team
    @mark = if @team == :white
              "\u2657"
            else
              "\u265D"
            end
  end
end
