# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  attr_reader :move_set

  def initialize(color)
    @move_set = set_move_set

    super(color)
  end

  def find_moves(board)
    moves = []

    @move_set.each do |direction|
      column = current_col + direction[0]
      row = current_row + direction[1]

      loop do
        break if Piece.out_of_bounds?(row, column)

        position = board.positions[row][column]

        if position.free?
          moves << [row, column]
        elsif position.occupied_by?(@color)
          break
        else
          moves << [row, column]
          break
        end

        column += direction[0]
        row += direction[1]
      end
    end

    moves
  end

  private

  def set_move_set
    [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
  end
end
