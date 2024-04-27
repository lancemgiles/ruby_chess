# frozen_string_literal: true

# Player objects move pieces on the board
class Player
  attr_accessor :turn, :team

  # make sure to enter 
  def initialize(team)
    @team = team
  end

  def move(start, target)
    start_x = start[0]
    start_y = start[1]
    target_x = target[0]
    target_y = target[1]
    ('a'..'h').to_a.each_with_index do |letter, index|
      start_y = index if start_y == letter
      target_y = index if target_y == letter
    end
    # needs to check if input is valid
    # identify piece at start
    piece = identify_piece(@board[start_x][start_y])
  end

  # determine what piece is in a position
  # return the piece if the space is occupied
  # return nil if the position is empty
  def identify_piece(pos)
    case pos
    when '_'
      nil
    end
  end
end
