# frozen_string_literal: true

# User Interface methods
module UI
  WHITE = {
    pawn: "\u265F",
    knight: "\u265E",
    bishop: "\u265D",
    rook: "\u265C",
    queen: "\u265B",
    king: "\u265A"
  }.freeze
  BLACK = {
    pawn: "\u2659",
    knight: "\u2658",
    bishop: "\u2657",
    rook: "\u2656",
    queen: "\u2655",
    king: "\u2654"
  }.freeze
  def show_board
    @board.each_with_index do |row, index|
      puts "\t\t#{index}|#{row.join('|')}|"
    end
    puts "\t\t  a b c d e f g h"
  end

  def intro
    puts "\tPlayer 1 is white."
    puts "\tTo move, first enter the coordinates of the piece you wish to move."
    puts "\tFor example, select a knight with 7g and press enter."
    puts "\tThen enter the target location."
  end
end

# Gameboard
class Board
  include UI
  attr_accessor :board, :white, :black, :units_w, :units_b

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
    @units_b = {}
    @units_w = {}
    populate
    show_board
    intro
  end

  def populate
    populate_pawns
    populate_bishops
    populate_knights
    populate_rooks
    populate_queens
    populate_kings
  end

  def populate_pawns
    8.times do |col|
      @units_w["pawn#{col}"] = Pawn.new(:white, [6, col])
      @board[6][col] = WHITE[:pawn]
      @units_b["pawn#{col}"] = Pawn.new(:black, [1, col])
      @board[1][col] = BLACK[:pawn]
    end
  end

  def populate_bishops
    @units_w['bishop2'] = Bishop.new(:white, [7, 2])
    @units_w['bishop5'] = Bishop.new(:white, [7, 5])
    @board[7][2] = @board[7][5] = WHITE[:bishop]
    @units_b['bishop2'] = Bishop.new(:black, [0, 2])
    @units_b['bishop5'] = Bishop.new(:black, [0, 5])
    @board[0][2] = @board[0][5] = BLACK[:bishop]
  end

  def populate_rooks
    @units_w['rook0'] = Rook.new(:white, [7, 0])
    @units_w['rook7'] = Rook.new(:white, [7, 7])
    @board[7][0] = @board[7][7] = WHITE[:rook]
    @units_b['rook0'] = Rook.new(:black, [0, 0])
    @units_b['rook7'] = Rook.new(:black, [0, 7])
    @board[0][7] = @board[0][0] = BLACK[:rook]
  end

  def populate_knights
    @units_w['knight1'] = Knight.new(:white, [7, 1])
    @units_w['knight6'] = Knight.new(:white, [7, 6])
    @board[7][1] = @board[7][6] = WHITE[:knight]
    @units_b['knight1'] = Knight.new(:black, [0, 1])
    @units_b['knight6'] = Knight.new(:black, [0, 6])
    @board[0][1] = @board[0][6] = BLACK[:knight]
  end

  def populate_queens
    @units_w['queen'] = Queen.new(:white, [7, 3])
    @board[7][3] = WHITE[:queen]
    @units_b['queen'] = Queen.new(:black, [0, 4])
    @board[0][4] = BLACK[:queen]
  end

  def populate_kings
    @units_w['king'] = King.new(:white, [7, 4])
    @board[7][4] = WHITE[:king]
    @units_b['king'] = King.new(:black, [0, 3])
    @board[0][3] = BLACK[:king]
  end

  def valid_pos?(pos)
    row, col = pos
    row >= 0 && row < 8 && col >= 0 && col < 8
  end
end
