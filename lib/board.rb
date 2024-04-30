# frozen_string_literal: true

# require_relative 'pieces'

# User Interface methods
module UI
  def show_board
    puts "\t\t  a b c d e f g h"
    @board.each_with_index do |row, index|
      puts "\t\t#{index}|#{row.join('|')}|#{index}"
    end
    puts "\t\t  a b c d e f g h"
    if @turn.odd?
      puts "\tWhite's turn"
    else
      puts "\tBlack's turn"
    end
  end

  def intro
    puts "\tTo move, first enter the coordinates of the piece you wish to move."
    puts "\tFor example, move a knight type g7 and press enter."
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
    state[4] = @check
  end

  def load
    puts 'Save file detected. Load saved game? (y/n)'
    ans = gets.downcase.chomp[0]
    return unless ans == 'y'

    @state = YAML.load_file('save.yml', aliases: true, permitted_classes: [Board, Piece, Pawn, Knight, Bishop, Rook, Queen, King, Symbol])
    @board = @state[0]
    @units_b = @state[1]
    @units_w = @state[2]
    @turn = @state[3]
    @check = @state[4]
    update_game
  end

  def move(start, target)
    check_sl(start, target)
    start = start.split('')
    target = target.split('')
    start_x = +start[0]
    start_y = +start[1].to_i
    target_x = +target[0]
    target_y = +target[1].to_i
    ('a'..'z').to_a.each_with_index do |letter, index|
      # goes beyond h to keep validation check from crashing
      start_x = index.to_s.to_i if start_x == letter
      target_x = index.to_s.to_i if target_x == letter
    end
    # need to check for check and checkmate and castling
    piece = @board[start_y][start_x]
    start_coord = [start_x, start_y]
    target_coord = [target_x, target_y]
    if valid_target?(piece, start_coord, target_coord)
      @board[target_y][target_x] = piece
      @board[start_y][start_x] = '_'
      piece.position = target_coord
      piece.first_move = false if piece.instance_of?(Pawn)
      promote(piece) if piece.instance_of?(Pawn)
      @last_move = piece
    else
      # change this eventually
      puts 'You entered an invalid move and now lose a turn!'
    end
  end

  def piece_in_path?(piece, start, target) end

  def friendly_piece?(piece, target) end

  # because knights can jump, this works for them. other pieces need to check for obstacles.
  def valid_target?(piece, start, target)
    return false if piece == '_'

    valid_targs = []
    if offensive_move?(piece) && @board[target[1]][target[0]] != '_'
      piece.move_set.push([1, 1], [-1, 1]) if piece.team == :white
      piece.move_set.push([1, -1], [-1, -1]) if piece.team == :black
    end
    piece.move_set.each do |pos|
      valid_targs << [(start[0] - pos[0]).abs, (start[1] - pos[1]).abs]
    end
    valid_targs.reverse_each do |targ|
      targ.reverse_each do |coord|
        valid_targs.delete(targ) if coord > 7
      end
    end
    p piece.class
    p valid_targs.sort
    if valid_targs.any?(target)
      sights = line_of_sight(valid_targs, target)
      obst = obstacles(sights, target)
      return true if obst.length.zero?
    end
  end

  def check_sl(start, target)
    input_coords if start.include?('save' || 'load')
    input_coords if target.include?('save' || 'load')
  end
end

# Gameboard
class Board
  include UI
  attr_accessor :board, :white, :black, :units_w, :units_b, :state, :turn, :check, :last_move

  def initialize
    intro
    @board = Array.new(8) { Array.new(8) { '_' } }
    @units_b = @units_w = {}
    @turn = 1
    @check = false
    @state = [@board, @units_b, @units_w, @turn, @check]
    populate
    show_board
    return unless File.exist?('save.yml')

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
    8.times do |x|
      @units_w["pawn#{x}"] = Pawn.new(:white, [x, 6])
      @board[6][x] = @units_w["pawn#{x}"]
      @units_b["pawn#{x}"] = Pawn.new(:black, [x, 1])
      @board[1][x] = @units_b["pawn#{x}"]
    end
  end

  def populate_bishops
    @units_w[:bishop2] = Bishop.new(:white, [2, 7])
    @units_w[:bishop5] = Bishop.new(:white, [5, 7])
    @board[7][2] = @units_w[:bishop2]
    @board[7][5] = @units_w[:bishop5]
    @units_b[:bishop2] = Bishop.new(:black, [2, 0])
    @units_b[:bishop5] = Bishop.new(:black, [5, 0])
    @board[0][2] = @units_b[:bishop2]
    @board[0][5] = @units_b[:bishop5]
  end

  def populate_knights
    @units_w[:knight1] = Knight.new(:white, [1, 7])
    @units_w[:knight6] = Knight.new(:white, [6, 7])
    @board[7][1] = @units_w[:knight1]
    @board[7][6] = @units_w[:knight6]
    @units_b[:knight1] = Knight.new(:black, [1, 0])
    @units_b[:knight6] = Knight.new(:black, [6, 0])
    @board[0][1] = @units_b[:knight1]
    @board[0][6] = @units_b[:knight6]
  end

  def populate_rooks
    @units_w[:rook0] = Rook.new(:white, [0, 7])
    @units_w[:rook7] = Rook.new(:white, [7, 7])
    @board[7][0] = @board[7][7] = @units_w[:rook0]
    @units_b[:rook0] = Rook.new(:black, [0, 0])
    @units_b[:rook7] = Rook.new(:black, [7, 0])
    @board[0][7] = @board[0][0] = @units_b[:rook0]
  end

  def populate_queens
    @units_w[:queen] = Queen.new(:white, [3, 7])
    @board[7][3] = @units_w[:queen]
    @units_b[:queen] = Queen.new(:black, [4, 0])
    @board[0][4] = @units_b[:queen]
  end

  def populate_kings
    @units_w[:king] = King.new(:white, [4, 7])
    @board[7][4] = @units_w[:king]
    @units_b[:king] = King.new(:black, [3, 0])
    @board[0][3] = @units_b[:king]
  end

  def update_game
    @state = [@board, @units_b, @units_w, @turn, @check]
    show_board
  end

  def offensive_move?(pawn)
    return false unless pawn.instance_of?(Pawn)

    attackable_w = [@board[pawn.position[1] - 1][pawn.position[0] - 1],
                    @board[pawn.position[1] - 1][pawn.position[0] + 1]]
    attackable_b = [@board[pawn.position[1] + 1][pawn.position[0] + 1],
                    @board[pawn.position[1] + 1][pawn.position[0] - 1]]
    if pawn.team == :white
      attackable_w.any? do |pos|
        pos.class.superclass == Piece && pos.team == :black
      end
    elsif pawn.team == :black
      attackable_b.any? do |pos|
        pos.class.superclass == Piece && pos.team == :white
      end
    else
      false
    end
  end

  def promote(pawn)
    if pawn.team == :white && pawn.position[1].zero?
      @units_w[:queen_p] = Queen.new(:white, pawn.position) 
      @board[pawn.position[1]][pawn.position[0]] = @units_w[:queen_p]
    end
    if pawn.team == :black && pawn.position[1] == 7
      @units_b[:queen_p] = Queen.new(:black, pawn.position) 
      @board[pawn.position[1]][pawn.position[0]] = @units_b[:queen_p]
    end
  end

  # return pieces other than the target which are in the range of possible moves
  # call this in #move with valid_targs as moves and confirming the target is valid
  def line_of_sight(moves, target)
    # return if piece.instance_of?(Knight)
    # check if there are any pieces in the path from start to target
    in_sights = moves
    in_sights.each do |pos|
      piece = @board[pos[1]][pos[0]]
      in_sights.delete(pos) if piece.instance_of?(String)
      next if piece.instance_of?(String)

      in_sights.delete(pos) if piece.position == target
    end
    # think of a rook at [7, 7] moving to [7, 0]
    # if there's a piece at [7, (0..6)] then the move is invalid
    # get a list of spaces between start and target

    # first, get all possible moves
    # any pieces that are in the list of possible moves but aren't the target could be in the way and are in the line of sight
    in_sights
  end

  def obstacles(sights, target)
    obstacles = []
    sights.sort!
    sights.each_with_index do |piece, index|
      sights.delete(piece) if piece[index] >= target[index]
      # remove any pieces which come after the target index as they aren't on the way to the target
      # assuming the piece is a queen moving diagonally all the way across the board, this trims nothing
      case piece
      when target[0] == piece[0]
        obstacles << piece
      when target[1] == piece[1]
        obstacles << piece
      else
        sights.delete(piece) if target[0] == piece[0] || target[1] == piece[1]
      end
    end
    obstacles
  end

  def check?(piece, start, target)
    puts 'Check!'
    @check = true
  end

  def play
    loop do
      move(input_coords, input_coords)
      @turn += 1
      update_game
    end
  end
end
