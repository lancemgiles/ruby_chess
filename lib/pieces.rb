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
  def move_set
    [
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2],
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1]
    ]
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
    moves = []
    8.times do |n|
      moves << [n, 0]
      moves << [0, n]
    end
    moves.uniq
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
