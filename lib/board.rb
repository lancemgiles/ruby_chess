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
    puts "\t\t  a b c d e f g h"
    @board.each_with_index do |row, index|
      puts "\t\t#{index}|#{row.join('|')}|"
    end
  end

  def intro
    puts "\tTo move, first enter the coordinates of the piece you wish to move."
    puts "\tFor example, move a knight type 7g and press enter."
    puts "\tThen enter the coordinates of where you want to move it."
    puts
    puts "\tEnter save, load, or quit to do those actions."
    puts "\tThis works more like a digital chess board with pieces rather than a video game!"
    puts "\tThat means that aside from checking if moves are legal and for winning conditions,"
    puts "\tit is on the players to play honestly."
    puts
    puts "\tPlayer 1 is white and goes first."
  end

  def input_coords
    print 'Enter coordinates: '
    coords = gets.chomp
    abort 'Quitting game...' if coords == 'quit'
    save(@state) if coords == 'save'
    if coords == 'load'
      load
    end
    coords
  end

  def save(state)
    update_state(state)
    puts 'Save game and quit playing? (y/n)'
    ans = gets.downcase.chomp
    return unless ans == 'y'

    File.open('save.yml', 'w') { |file| YAML.dump(state, file) }
    abort 'Game saved.'
  end

  def update_state(state)
    state[0] = @board
    state[1] = @units_b
    state[2] = @units_w
  end

  def load
    puts 'Load saved game? (y/n)'
    ans = gets.downcase.chomp[0]
    return unless ans == 'y'

    @state = YAML.load_file('save.yml', aliases: true, permitted_classes: [Board, Piece, Pawn, Knight, Bishop, Rook, Queen, King, Symbol])
    @board = @state[0]
    @units_b = state[1]
    @units_w = state[2]
    update_game
  end

  def move(start, target)
    if start == 'save' ||
       start == 'load'
      start = input_coords
    elsif target == 'save' ||
          target == 'load'
      target = input_coords
    end
    start = start.split('')
    target = target.split('')
    start_x = +start[0].to_i
    start_y = +start[1]
    target_x = +target[0].to_i
    target_y = +target[1]
    ('a'..'h').to_a.each_with_index do |letter, index|
      if start_y == letter
        start_y = index.to_s
        start_y = start_y.to_i
      end
      if target_y == letter
        target_y = index.to_s
        target_y = target_y.to_i
      end
    end
    # need to check if input is valid
    # need to confirm selected piece is not empty
    piece = @board[start_x][start_y]
    @board[target_x][target_y] = piece
    @board[start_x][start_y] = '_'
  end
end

# Gameboard
class Board
  include UI
  attr_accessor :board, :white, :black, :units_w, :units_b, :state

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
    @units_b = {}
    @units_w = {}
    @state = [@board, @units_b, @units_w]
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

  def update_game
    @state = [@board, @units_b, @units_w]
    show_board
  end

  def play
    loop do
      move(input_coords, input_coords)
      update_game
    end
  end

  def valid_pos?(pos)
    row, col = pos
    row >= 0 && row < 8 && col >= 0 && col < 8
  end
end
