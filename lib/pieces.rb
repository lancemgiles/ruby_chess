# frozen_string_literal: true

# Class for comment elements of all pieces
class Piece
  attr_accessor :team, :move_set, :position

  def initialize(team, position)
    @team = team
    @position = position
  end
end

# Pawns
class Pawn < Piece
  attr_accessor :first_move

  def initialize(team, position)
    super
    @first_move = true
  end

  def possible_moves
    moves = [[0, 1]]
    first_move = false if @position != @board[6]
    [0, 2] << moves if first_move
    # needs diagonal move for attack
  end

  def to_s
    return "\u265F" if @team == :white

    return "\u2659" if @team == :black
  end
end

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

  def to_s
    return "\u265E" if @team == :white

    return "\u2658" if @team == :black
  end
end

# Bishop
class Bishop < Piece
  def to_s
    return "\u265D" if @team == :white

    return "\u2657" if @team == :black
  end
end

# Rook
class Rook < Piece
  def to_s
    return "\u265C" if @team == :white

    return "\u2656" if @team == :black
  end
end

# Queen
class Queen < Piece
  def to_s
    return "\u265B" if @team == :white

    return "\u2655" if @team == :black
  end
end

# King
class King < Piece
  POSSIBLE_MOVES = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0],
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ].freeze

  def to_s
    return "\u265A" if @team == :white

    return "\u2654" if @team == :black
  end
end
