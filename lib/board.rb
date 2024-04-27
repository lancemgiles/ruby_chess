# frozen_string_literal: true

# Gameboard
class Board
  attr_accessor :board, :white, :black, :units_w, :units_b

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
    @units_b = {}
    @units_w = {}
    populate
    show_board
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
      @board[6][col] = @units_w["pawn#{col}"].mark
      @units_b["pawn#{col}"] = Pawn.new(:black, [1, col])
      @board[1][col] = @units_b["pawn#{col}"].mark
    end
  end

  def populate_bishops
    @units_w['bishop2'] = Bishop.new(:white, [7, 2])
    @board[7][2] = @units_w['bishop2'].mark
    @units_w['bishop5'] = Bishop.new(:white, [7, 5])
    @board[7][5] = @units_w['bishop5'].mark
    @units_b['bishop2'] = Bishop.new(:black, [0, 2])
    @board[0][2] = @units_b['bishop2'].mark
    @units_b['bishop5'] = Bishop.new(:black, [0, 5])
    @board[0][5] = @units_b['bishop5'].mark
  end

  def populate_rooks
    @units_w['rook0'] = Rook.new(:white, [7, 0])
    @board[7][0] = @units_w['rook0'].mark
    @units_w['rook7'] = Rook.new(:white, [7, 7])
    @board[7][7] = @units_w['rook7'].mark
    @units_b['rook0'] = Rook.new(:black, [0, 0])
    @board[0][0] = @units_b['rook0'].mark
    @units_b['rook7'] = Rook.new(:black, [0, 7])
    @board[0][7] = @units_b['rook7'].mark
  end

  def populate_knights
    @units_w['knight1'] = Knight.new(:white, [7, 1])
    @board[7][1] = @units_w['knight1'].mark
    @units_w['knight6'] = Knight.new(:white, [7, 6])
    @board[7][6] = @units_w['knight6'].mark
    @units_b['knight1'] = Knight.new(:black, [0, 1])
    @board[0][1] = @units_b['knight1'].mark
    @units_b['knight6'] = Knight.new(:black, [0, 6])
    @board[0][6] = @units_b['knight6'].mark
  end

  def populate_queens
    @units_w['queen'] = Queen.new(:white, [7, 3])
    @board[7][3] = @units_w['queen'].mark
    @units_b['queen'] = Queen.new(:black, [0, 4])
    @board[0][4] = @units_b['queen'].mark
  end

  def populate_kings
    @units_w['king'] = King.new(:white, [7, 4])
    @board[7][4] = @units_w['king'].mark
    @units_b['king'] = King.new(:black, [0, 3])
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
