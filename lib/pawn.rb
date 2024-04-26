# frozen_string_literal: true

require_relative 'piece'

# Pawn
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
