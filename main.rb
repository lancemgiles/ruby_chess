# frozen_string_literal: true

require './lib/pieces'
require './lib/board'
require './lib/player'

game = Board.new
game.move('7g', '5f')
game.show_board