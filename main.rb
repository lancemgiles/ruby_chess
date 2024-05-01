# frozen_string_literal: true

require './lib/pieces'
require './lib/board'
require 'yaml'
require 'rainbow/refinement'
using Rainbow

game = Board.new
game.play
game.show_board
