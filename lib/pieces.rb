# frozen_string_literal: true

# Class for comment elements of all pieces
class Piece
  attr_accessor :team, :position

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

  def move_set
    moves = [[0, 1]]
    # first_move = false if @position != @board[6]
    [0, 2] << moves if first_move
    # needs diagonal move for attack
    moves
  end

  def to_s
    return "\u265F" if @team == :white

    return "\u2659" if @team == :black
  end
end

# Knight
class Knight < Piece
  def valid_move?(target)
    # knights can jump over pieces, so no obsructions need to be considered
    # but the knight cannot take pieces from its own side
    # to check if a target position is valid:
    # for each position in this set, apply it to the start position
    # so if start position if 7g, that becomes [7, 6]
    # every possible position would then be calculated
    # subtraction moves to the right and up
    # [8, 8] - remove because it is outside of the range allowed by the board
    # [8, 4] - ditto
    # [6, 8] - ditto
    # [6, 4] - valid position only if no piece from the same side is there
    # [9, 7] - out of board
    # [9, 5] - out of board
    # [5, 7] - valid only if no piece from the same side is there
    # [5, 5] - ditto
    move_set = [
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2],
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1]
    ]
    move_set.each do |pos|
      targ = [target[0] + pos[0], target[1] + pos[1]]
      return false if targ.any? { |n| n >= 8 || n <= 0 }

      true
    end
  end

  def to_s
    return "\u265E" if @team == :white

    return "\u2658" if @team == :black
  end
end

# Bishop
class Bishop < Piece
  def move_set
  end
  def to_s
    return "\u265D" if @team == :white

    return "\u2657" if @team == :black
  end
end

# Rook
class Rook < Piece
  def move_set
  end
  def to_s
    return "\u265C" if @team == :white

    return "\u2656" if @team == :black
  end
end

# Queen
class Queen < Piece
  def move_set
  end
  def to_s
    return "\u265B" if @team == :white

    return "\u2655" if @team == :black
  end
end

# King
class King < Piece
  def move_set
    [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
  end

  def to_s
    return "\u265A" if @team == :white

    return "\u2654" if @team == :black
  end
end
