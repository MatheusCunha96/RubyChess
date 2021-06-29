# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  attr_accessor :image
  attr_reader :possible_moves

  def initialize(color)
    @possible_moves = set_possible_moves

    super(color, color == 'white' ? '♜' : '♖')
  end

  def find_moves(board)
    moves = []

    @possible_moves.each do |move|
      column = current_col + move[0]
      row = current_row + move[1]

      loop do
        # TODO: set this condition as board function
        break if column > 7 || column < 0 || row > 7 || row < 0
        position_state = board.position_state(row, column)

        if position_state.nil?
          moves << [row, column]
        elsif position_state != @color
          moves << [row, column]
          break
        elsif position_state == @color
          break
        end

        column += move[0]
        row += move[1]
      end
    end

    moves
  end

  private

  def set_possible_moves
    [
      [0,1],
      [0,-1],
      [1,0],
      [-1,0],
    ]
  end

end
