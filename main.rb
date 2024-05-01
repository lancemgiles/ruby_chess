# frozen_string_literal: true

require './lib/pieces'
require './lib/board'
require 'yaml'

game = Board.new
game.play
game.show_board
