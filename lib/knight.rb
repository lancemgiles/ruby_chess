# frozen_string_literal: true

require_relative 'piece'

# Knight
class Knight < Piece
  POSSIBLE_MOVES = [
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1]
  ].freeze

  def initialize(team)
    super()
    @team = team
    @mark = if @team == :white
              "\u2658"
            else
              "\u265E"
            end
  end
end
