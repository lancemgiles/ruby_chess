# frozen_string_literal: true

require_relative "pieces"

# User Interface methods
module UI
  def show_board
    puts "\t\t  a b c d e f g h"
    @board.each_with_index do |row, index|
      puts "\t\t#{index}|#{row.join('|')}|"
    end
    if @turn.odd?
      puts "\tWhite's turn"
    else
      puts "\tBlack's turn"
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
    load if coords == 'load'
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
    state[3] = @turn
  end

  def load
    puts 'Load saved game? (y/n)'
    ans = gets.downcase.chomp[0]
    return unless ans == 'y'

    @state = YAML.load_file('save.yml', aliases: true, permitted_classes: [Board, Piece, Pawn, Knight, Bishop, Rook, Queen, King, Symbol])
    @board = @state[0]
    @units_b = state[1]
    @units_w = state[2]
    @turn = state[3]
    update_game
  end

  def move(start, target)
    check_sl(start, target)
    start = start.split('')
    target = target.split('')
    start_x = +start[0].to_i
    start_y = +start[1]
    target_x = +target[0].to_i
    target_y = +target[1]
    ('a'..'z').to_a.each_with_index do |letter, index|
      # goes beyond h for validation check
      start_y = index.to_s.to_i if start_y == letter
      target_y = index.to_s.to_i if target_y == letter
    end
    # currently does not check if input is valid
    # this game allows for cheating by moving the other player's peice
    # but it should make sure that the selected piece moves the way it is supposed to
    # need to check for check and checkmate and castling
    piece = @board[start_x][start_y]
    target_coord = [target_x, target_y]
    if piece.valid_move?(target_coord)
      # check if target is within reach of the piece's moveset (including obstacles)
      @board[target_x][target_y] = piece
      @board[start_x][start_y] = '_'
      piece.position = target_coord
    else
      # change this eventually
      puts 'You entered an invalid move and now lose a turn!'
    end
  end

  def check_sl(start, target)
    if start == 'save' ||
       start == 'load'
     start = input_coords
     start
    elsif target == 'save' ||
          target == 'load'
     target = input_coords
     target
    end
  end
end

# Gameboard
class Board
  include UI
  attr_accessor :board, :white, :black, :units_w, :units_b, :state, :turn

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
    @units_b = {}
    @units_w = {}
    @turn = 1
    @state = [@board, @units_b, @units_w, @turn]
    populate
    show_board
    intro
    return unless File.exist?('save.yml')

    puts 'Save file detected.'
    self.load
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
      @board[6][col] = @units_w["pawn#{col}"]
      @units_b["pawn#{col}"] = Pawn.new(:black, [1, col])
      @board[1][col] = @units_b["pawn#{col}"]
    end
  end

  def populate_bishops
    @units_w[:bishop2] = Bishop.new(:white, [7, 2])
    @units_w[:bishop5] = Bishop.new(:white, [7, 5])
    @board[7][2] = @units_w[:bishop2]
    @board[7][5] = @units_w[:bishop5]
    @units_b[:bishop2] = Bishop.new(:black, [0, 2])
    @units_b[:bishop5] = Bishop.new(:black, [0, 5])
    @board[0][2] = @units_b[:bishop2]
    @board[0][5] = @units_b[:bishop5]
  end

  def populate_knights
    @units_w[:knight1] = Knight.new(:white, [7, 1])
    @units_w[:knight6] = Knight.new(:white, [7, 6])
    @board[7][1] = @units_w[:knight1]
    @board[7][6] = @units_w[:knight6]
    @units_b[:knight1] = Knight.new(:black, [0, 1])
    @units_b[:knight6] = Knight.new(:black, [0, 6])
    @board[0][1] = @units_b[:knight1]
    @board[0][6] = @units_b[:knight6]
  end

  def populate_rooks
    @units_w[:rook0] = Rook.new(:white, [7, 0])
    @units_w[:rook7] = Rook.new(:white, [7, 7])
    @board[7][0] = @board[7][7] = @units_w[:rook0].to_s
    @units_b[:rook0] = Rook.new(:black, [0, 0])
    @units_b[:rook7] = Rook.new(:black, [0, 7])
    @board[0][7] = @board[0][0] = @units_b[:rook0].to_s
  end

  def populate_queens
    @units_w[:queen] = Queen.new(:white, [7, 3])
    @board[7][3] = @units_w[:queen]
    @units_b[:queen] = Queen.new(:black, [0, 4])
    @board[0][4] = @units_b[:queen]
  end

  def populate_kings
    @units_w[:king] = King.new(:white, [7, 4])
    @board[7][4] = @units_w[:king]
    @units_b[:king] = King.new(:black, [0, 3])
    @board[0][3] = @units_b[:king]
  end

  def update_game
    @state = [@board, @units_b, @units_w, @turn]
    show_board
  end

  def play
    loop do
      move(input_coords, input_coords)
      @turn += 1
      update_game
    end
  end

  def valid_pos?(pos)
    row, col = pos
    row >= 0 && row < 8 && col >= 0 && col < 8
  end
end
