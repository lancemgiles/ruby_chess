# frozen_string_literal: true

# Gameboard
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) { '_' } }
  end

  def show_board
    @board.each_with_index do |row, index|
      puts "#{index}|#{row.join('|')}|"
    end
    puts '  A B C D E F G H'
  end
end

game = Board.new
game.show_board
