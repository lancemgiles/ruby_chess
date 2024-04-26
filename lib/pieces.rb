# frozen_string_literal: true

# Class for comment elements of all pieces
class Piece
  attr_accessor :position, :mark, :team

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
    @mark = if @team == 'white'
              "\u265F"
            else
              "\u2659"
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

  def initialize(team, position)
    super
    @mark = if @team == 'white'
              "\u265E"
            else
              "\u2658"
            end
  end
end

# Bishop
class Bishop < Piece
  def initialize(team, position)
    super
    @mark = if @team == 'white'
              "\u265D"
            else
              "\u2657"
            end
  end
end

# Rook
class Rook < Piece
  def initialize(team, position)
    super
    @mark = if @team == 'white'
              "\u265C"
            else
              "\u2656"
            end
  end
end

# Queen
class Queen < Piece
  def initialize(team, position)
    super
    @mark = if @team == 'white'
              "\u265B"
            else
              "\u2655"
            end
  end
end

# King
class King < Piece
  def initialize(team, position)
    super
    @mark = if @team == 'white'
              "\u265A"
            else
              "\u2654"
            end
  end
end
