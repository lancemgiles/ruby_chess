# frozen_string_literal: true

# Gameboard
class Board
  attr_accessor :board, :white, :black, :pawns_w, :pawns_b

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
    populate_pawns
    show_board
  end

  def populate_pawns
    @pawns_w = {}
    @pawns_b = {}
    8.times do |n|
      @pawns_w["pawn#{n}"] = Pawn.new('white')
      @pawns_b["pawn#{n}"] = Pawn.new('black')
    end
    @board[1].each_index do |col|
      @pawns_w["pawn#{col}"].position = [1, col]
      @board[1][col] = @pawns_w['pawn0'].mark
    end
    @board[6].each_index do |col|
      @pawns_b["pawn#{col}"].position = [6, col]
      @board[6][col] = @pawns_b['pawn0'].mark
    end
  end

  def show_board
    @board.each_with_index do |row, index|
      puts "\t\t#{index}|#{row.join('|')}|"
    end
    puts "\t\t  A B C D E F G H"
  end

  def valid_pos?(pos)
    row, col = pos
    row >= 0 && row < 8 && col >= 0 && col < 8
  end
end


