# frozen_string_literal: true

# Gameboard
class Board
  attr_accessor :board, :white, :black, :units_w, :units_b

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
    @units_b = {}
    @units_w = {}
    populate_pawns
    populate_kings
    show_board
  end

  def populate_pawns
    8.times do |n|
      @units_w["pawn#{n}"] = Pawn.new('white')
      @units_b["pawn#{n}"] = Pawn.new('black')
    end
    @board[6].each_index do |col|
      @units_w["pawn#{col}"].position = [6, col]
      @board[6][col] = @units_w['pawn0'].mark
    end
    @board[1].each_index do |col|
      @units_b["pawn#{col}"].position = [1, col]
      @board[1][col] = @units_b['pawn0'].mark
    end
  end

  def populate_kings
    @units_w['king'] = King.new('white')
    @units_w['king'].position = [0, 4]
    @board[7][4] = @units_w['king'].mark
    @units_b['king'] = King.new('black')
    @units_b['king'].position = [0, 3]
    @board[0][3] = @units_b['king'].mark
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
