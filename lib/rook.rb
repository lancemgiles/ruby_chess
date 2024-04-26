# frozen_string_literal: true

require_relative 'piece'

# Rook
class Rook < Piece
  def initialize(team)
    super()
    @team = team
    @mark = if @team == :white
              "\u2656"
            else
              "\u265C"
            end
  end
end
