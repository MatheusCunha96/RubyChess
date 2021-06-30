# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  attr_accessor :image
  attr_reader :possible_moves

  def initialize(color)
    @possible_moves = set_possible_moves

    super(color, color == 'white' ? '♞' : '♘')
  end

  def find_moves(board)
    moves = []

    @possible_moves.each do |move|
      column = current_col + move[0]
      row = current_row + move[1]

      next if Piece.out_of_bounds?(row, column)

      position_state = board.position_state(row, column)

      moves << [row, column] if position_state.nil? || position_state != @color
    end

    moves
  end

  private

  def set_possible_moves
    [
      [2,1],
      [2,-1],
      [1,2],
      [-1,2],
      [-2,-1],
      [-2, 1],
      [-1,-2],
      [1,-2]
    ]
  end
end
