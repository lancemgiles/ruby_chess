# frozen_string_literal: true

# require_relative '../lib/piece'
# require_relative 'king'
# require_relative 'queen'
# require_relative 'rook'
# require_relative 'knight'
# require_relative 'bishop'
require_relative 'pawn'

# Gameboard
class Board
  attr_accessor :board, :white, :black

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
    populate_pawns
    show_board
  end

  def populate_pawns
    8.times do
      Pawn.new(@white)
      Pawn.new(@black)
    end
    @board[6].each_index do |col|
      @board[6][col] = "\u2659"
    end
    @board[1].each_index do |col|
      @board[1][col] = "\u265F"
    end
  end

  def show_board
    @board.each_with_index do |row, index|
      puts "#{index}|#{row.join('|')}|"
    end
    puts '  A B C D E F G H'
  end

  def valid_pos?(pos)
    row, col = pos
    row >= 0 && row < 8 && col >= 0 && col < 8
  end
end

game = Board.new
