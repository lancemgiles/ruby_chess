# frozen_string_literal: true

# Class for comment elements of all pieces
class Piece
  attr_accessor :position, :mark, :team
end

# Pawns
class Pawn < Piece
  attr_accessor :first_move

  def initialize(team)
    super()
    @team = team
    @mark = if @team == @white
              "\u2659"
            else
              "\u265F"
            end
    @first_move = true
  end

  def possible_moves
    moves = [[0, 1]]
    first_move = false if @position != @board[6]
    [0, 2] << moves if first_move
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

# Queen
class Queen < Piece
  def initialize(team)
    super()
    @team = team
    @mark = if @team == :white
              "\u2655"
            else
              "\u265B"
            end
  end
end

# King
class King < Piece
  def initialize(team)
    super()
    @team = team
    @mark = if @team == :white
              "\u2654"
            else
              "\u265A"
            end
  end
end
