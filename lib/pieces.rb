# frozen_string_literal: true

# Class for comment elements of all pieces
class Piece
  attr_accessor :piece, :mark, :team, :move_set, :position

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
end

# Bishop
class Bishop < Piece
end

# Rook
class Rook < Piece
end

# Queen
class Queen < Piece
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
end
