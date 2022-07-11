# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  def initialize(color)
    @move_set = set_move_set
    super(color)
  end

  def find_moves(board)
    moves = []

    @move_set.each do |direction|
      column = current_col + direction[0]
      row = current_row + direction[1]

      next if Piece.out_of_bounds?(row, column)

      position_state = board.position_state(row, column)

      if position_state.nil?
        moves << [row, column]
      elsif position_state != @color
        moves << [row, column]
      end
    end

    moves
  end

  private

  def set_move_set
    [
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
  end
end
